vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KDE/kpackage
    REF v5.64.0
    SHA512 54d1ea1ccdba3da5c7b82c04a45887b2f05cfa8af0e2ca64b14d9295ea3d59e21f1e42b759d492d6f107a0a5d93ebf87821855f4625a9ddf40d774b1afadc0e6
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
            -DKDE_INSTALL_DATAROOTDIR=data
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/KF5Package)
vcpkg_copy_pdbs()

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/kf5package)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/kpackagetool5.exe ${CURRENT_PACKAGES_DIR}/tools/kf5package/kpackagetool5.exe)
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/kf5package)

file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/kpackagetool5.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/etc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/etc)
file(INSTALL ${SOURCE_PATH}/COPYING.LIB DESTINATION ${CURRENT_PACKAGES_DIR}/share/kf5package RENAME copyright)