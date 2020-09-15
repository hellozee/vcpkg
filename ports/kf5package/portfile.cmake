vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KDE/kpackage
    REF v5.73.0
    SHA512 b9fe2179ea0c6b52f1e451631dc3384836c6f241c46102bebc0d218c13fe6505d2ffc7c53c0f0b3805f71fc1fac5ca8e6b98bed26a6463e3b46b0645420bd823
    HEAD_REF master
)

vcpkg_find_acquire_program(GETTEXT_MSGMERGE)
get_filename_component(GETTEXT_MSGMERGE_EXE_PATH ${GETTEXT_MSGMERGE} DIRECTORY)
vcpkg_add_to_path(${GETTEXT_MSGMERGE_EXE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DBUILD_HTML_DOCS=OFF
            -DBUILD_MAN_DOCS=OFF
            -DBUILD_QTHELP_DOCS=OFF
            -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/KF5Package)
vcpkg_copy_pdbs()

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/kf5package)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/kpackagetool5${VCPKG_HOST_EXECUTABLE_SUFFIX})
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/kpackagetool5${VCPKG_HOST_EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/kf5package/kpackagetool5${VCPKG_HOST_EXECUTABLE_SUFFIX})

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/etc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/etc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL ${SOURCE_PATH}/COPYING.LIB DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
