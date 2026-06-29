cmake_minimum_required(VERSION 3.31.6)
project(CMakeHDL LANGUAGES NONE)
if(PROJECT_IS_TOP_LEVEL)
    include(CTest)
    add_subdirectory(test)
endif()
add_custom_target(CMakeHDL)
set_target_properties(
    CMakeHDL
    PROPERTIES
        CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}"
        PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}"
)