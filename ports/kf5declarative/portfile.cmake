vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KDE/kdeclarative
    REF v5.64.0
    SHA512 41a449ec195f23fcfb5762b9d45b4f58b7d02f8eddfaad345b64cd2db742afaa3a014f5843f1591c88776ec439ea7859004cf646bf19e48daf473b6061df0323
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
            -DKDE_INSTALL_QMLDIR=qml
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/KF5Declarative)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/kpackagelauncherqml.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/kpackagelauncherqml.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/etc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/etc)
file(INSTALL ${SOURCE_PATH}/COPYING.LIB DESTINATION ${CURRENT_PACKAGES_DIR}/share/kf5declarative RENAME copyright)