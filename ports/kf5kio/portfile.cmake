vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KDE/kio
    REF v5.64.0
    SHA512 b5759f242880258a63401ddb3f9336682a7094e0eb38a31afc26812dec1426eb8212f96b1bf856344258e0dbcaa04948074a1f8f9f64b965381293855a071795
    HEAD_REF master
    PATCHES
        qt_nodiscard.patch
)

vcpkg_acquire_msys(MSYS_ROOT PACKAGES mingw-w64-i686-gettext)
set(GETTEXT_PATH ${MSYS_ROOT}/mingw32/bin)
vcpkg_add_to_path(${GETTEXT_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DBUILD_HTML_DOCS=OFF
            -DBUILD_MAN_DOCS=OFF
            -DBUILD_QTHELP_DOCS=OFF
            -DBUILD_TESTING=OFF
            -DKDE_INSTALL_PLUGINDIR=plugins
            -DKDE_INSTALL_DATAROOTDIR=data
            -DBUILD_DESIGNERPLUGIN=OFF
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/KF5KIO)
vcpkg_copy_pdbs()

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/kf5kio)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/protocoltojson.exe ${CURRENT_PACKAGES_DIR}/tools/kf5kio/protocoltojson.exe)
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/kf5kio)
file(APPEND ${CURRENT_PACKAGES_DIR}/tools/kf5kio/qt.conf "Data = ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/data")

file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/kcookiejar5.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/ktelnetservice5.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/ktrash5.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/kio_http_cache_cleaner.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/kioslave5.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/kioexec.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/kiod5.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/kcookiejar5.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/ktelnetservice5.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/ktrash5.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/protocoltojson.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/kio_http_cache_cleaner.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/kioslave5.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/kioexec.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/kiod5.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/etc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/etc)
file(INSTALL ${SOURCE_PATH}/COPYING.LIB DESTINATION ${CURRENT_PACKAGES_DIR}/share/kf5kio RENAME copyright)