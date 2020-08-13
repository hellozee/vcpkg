vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KDE/sonnet
    REF v5.64.0
    SHA512 86f18e60007330ec54f8613c3b24cb51ca5dbaf407ad48d32292319fd08be844cb8a0901530dcf163fc986947ee277763d81ef141f5da73e37f6d66f24a1739b
    HEAD_REF master
)

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

vcpkg_add_to_path(${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
vcpkg_add_to_path(${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
vcpkg_install_cmake()

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/kf5sonnet)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/gentrigrams.exe ${CURRENT_PACKAGES_DIR}/tools/kf5sonnet/gentrigrams.exe)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/parsetrigrams.exe ${CURRENT_PACKAGES_DIR}/tools/kf5sonnet/parsetrigrams.exe)

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/KF5Sonnet)

vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/kf5sonnet)
file(APPEND ${CURRENT_PACKAGES_DIR}/tools/kf5sonnet/qt.conf "Data = ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/data")
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/data)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/gentrigrams.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/parsetrigrams.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/etc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/etc)
file(INSTALL ${SOURCE_PATH}/COPYING.LIB DESTINATION ${CURRENT_PACKAGES_DIR}/share/kf5sonnet RENAME copyright)