vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KDE/syntax-highlighting
    REF v5.75.0
    SHA512 bb3b722861823b8ebe407b859b425c2f600af6686c2b1107436c55931e50e746e0852df8b11c5ad895323236a2ee857bcfe8a17af563c26baa4541535d275f8c
    HEAD_REF master
)

vcpkg_find_acquire_program(PERL)
get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
vcpkg_add_to_path("${PERL_EXE_PATH}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DBUILD_HTML_DOCS=OFF
            -DBUILD_MAN_DOCS=OFF
            -DBUILD_QTHELP_DOCS=OFF
            -DBUILD_TESTING=OFF
)

vcpkg_install_cmake(ADD_BIN_TO_PATH)
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/KF5SyntaxHighlighting)
vcpkg_copy_pdbs()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")	
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")	
elseif(VCPKG_TARGET_IS_WINDOWS)
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin/kate-syntax-highlighter.exe" "${CURRENT_PACKAGES_DIR}/debug/bin/kate-syntax-highlighter.exe")
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)