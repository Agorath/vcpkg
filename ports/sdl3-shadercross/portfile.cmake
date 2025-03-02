vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libsdl-org/SDL_shadercross
    REF ba0ed2701477b6ae61f851f52875daf4cee141ca
    SHA512 b30c74773002a1d21bd12ca9c92c0a254d0681827fb5a442addf2f61b6d1de55548f1fbefdeb87e7c5e765e6ddaa7d92008795067c04385108e05ddebf04255a
    HEAD_REF main
)

if(NOT VCPKG_TARGET_IS_WINDOWS)
    vcpkg_find_acquire_program(BISON)
    get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
    vcpkg_add_to_path("${BISON_DIR}")
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DSDLSHADERCROSS_SPIRVCROSS_SHARED=OFF
        -DSDLSHADERCROSS_INSTALL=ON
        -DSDLSHADERCROSS_INSTALL_CMAKEDIR_ROOT=share/${PORT}
        -DSDLSHADERCROSS_INSTALL_RUNTIME=OFF
        -DSDLSHADERCROSS_VENDORED=OFF
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

vcpkg_cmake_config_fixup(CONFIG_PATH share/${PORT} PACKAGE_NAME "sdl3_shadercross")

vcpkg_copy_tools(TOOL_NAMES shadercross AUTO_CLEAN)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
