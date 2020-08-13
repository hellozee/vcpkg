vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KDE/kxmlgui
    REF v5.64.0
    SHA512 a3ae526eba2621608c5be3a849dfaebd5545e9e371b58ca3478bfc0cc98222e0bc36974fcb6892cb2c0216d9f9798f6cc57753755f0254685eee2fc8a3f7c473
    HEAD_REF master
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
            -DBUILD_DESIGNERPLUGIN=OFF
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/KF5XmlGui)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/ksendbugmail.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/ksendbugmail.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/etc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/etc)
file(INSTALL ${SOURCE_PATH}/COPYING.LIB DESTINATION ${CURRENT_PACKAGES_DIR}/share/kf5xmlgui RENAME copyright)