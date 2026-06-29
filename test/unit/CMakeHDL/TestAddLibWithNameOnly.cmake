include(CMakeHDL)

macro(CMakeHDL_file)
    set_property(GLOBAL PROPERTY CMakeHDL_file 1)
    if(NOT "${ARGN}" STREQUAL "MAKE_DIRECTORY;/cmake/binary/dir/CMakeHDL/hello.dir")
        message(FATAL_ERROR "unexpected ARGN")
    endif()
endmacro()

macro(CMakeHDL_search_sources)
endmacro()

macro(CMakeHDL_search_file_deps)
endmacro()

macro(CMakeHDL_add_build_library_command)
    set_property(GLOBAL PROPERTY CMakeHDL_add_build_library_command 1)
    if(NOT "${ARGN}" STREQUAL "hello;DEPENDS;OUTPUT_FILE_VARIABLE;output_file;SOURCES;WORKING_DIRECTORY;/cmake/binary/dir/CMakeHDL/hello.dir")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
    set(output_file /cmake/binary/dir/CMakeHDL/hello.dir/.touch)
endmacro()

macro(CMakeHDL_add_custom_target)
    set_property(GLOBAL PROPERTY CMakeHDL_add_custom_target 1)
    if(NOT "${ARGN}" STREQUAL "hello;DEPENDS;/cmake/binary/dir/CMakeHDL/hello.dir/.touch")
        message(FATAL_ERROR "unexpected ARGN parameter, got: ${ARGN}")
    endif()
endmacro()

macro(CMakeHDL_set_target_properties)
    set_property(GLOBAL PROPERTY CMakeHDL_set_target_properties 1)
    if(NOT "${ARGN}" STREQUAL "hello;PROPERTIES;CMakeHDL_LIBRARY;TRUE;OUTPUT_FILE;/cmake/binary/dir/CMakeHDL/hello.dir/.touch;SOURCES;;WORKING_DIRECTORY;/cmake/binary/dir/CMakeHDL/hello.dir")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endmacro()

set(CMAKE_BINARY_DIR "/cmake/binary/dir")
CMakeHDL_add_library(NAME hello)

get_property(called GLOBAL PROPERTY CMakeHDL_file SET)
if(NOT called)
    message(FATAL_ERROR "CMakeHDL_file was not called")
endif()

get_property(called GLOBAL PROPERTY CMakeHDL_add_build_library_command SET)
if(NOT called)
    message(FATAL_ERROR "CMakeHDL_add_build_library_command was not called")
endif()

get_property(called GLOBAL PROPERTY CMakeHDL_add_custom_target SET)
if(NOT called)
    message(FATAL_ERROR "CMakeHDL_add_custom_target was not called")
endif()

get_property(called GLOBAL PROPERTY CMakeHDL_set_target_properties SET)
if(NOT called)
    message(FATAL_ERROR "CMakeHDL_set_target_properties was not called")
endif()