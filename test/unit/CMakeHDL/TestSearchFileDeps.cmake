include(CMakeHDL)

macro(CMakeHDL_search_sources output_var)
    set_property(GLOBAL PROPERTY CMakeHDL_search_sources TRUE)
    if(NOT ARGN STREQUAL "WORK_LIBRARY;lib1;SOURCES;/src/a.vhd;/src/b.txt")
        message(FATAL_ERROR "unexpected libraries, got: ${ARGN}")
    endif()
    set("${output_var}" "/src/a.vhd;/src/b.txt")
endmacro()

macro(CMakeHDL_get_target_property)
    set_property(GLOBAL PROPERTY CMakeHDL_get_target_property TRUE)
    if(NOT "${ARGN}" STREQUAL "output_file;lib1;OUTPUT_FILE")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
    set(output_file "/build/lib1/.touch")
endmacro()

CMakeHDL_search_file_deps(
    file_deps_var
    WORK_LIBRARY lib1
    SOURCES /src/a.vhd /src/b.txt
)

get_property(called GLOBAL PROPERTY CMakeHDL_get_target_property SET)
if(NOT called)
    message(FATAL_ERROR "CMakeHDL_get_target_property was not called")
endif()

get_property(called GLOBAL PROPERTY CMakeHDL_search_sources SET)
if(NOT called)
    message(FATAL_ERROR "CMakeHDL_search_sources was not called")
endif()

if(NOT "${file_deps_var}" STREQUAL "/build/lib1/.touch;/src/a.vhd;/src/b.txt")
    message(FATAL_ERROR "unexpected file_deps_var, got: ${file_deps_var}")
endif()