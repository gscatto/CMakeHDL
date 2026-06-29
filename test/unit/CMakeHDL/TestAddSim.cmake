include(CMakeHDL)

macro(CMakeHDL_file)
    if(NOT "${ARGN}" STREQUAL "MAKE_DIRECTORY;/build/CMakeHDL/hello.dir")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endmacro()

macro(CMakeHDL_add_build_simulation_command)
    if(NOT "${ARGN}" STREQUAL "hello;DEPENDS;<file_deps>;OUTPUT_FILE_VARIABLE;build_output_file;VHDL_TOP_ARCHITECTURE;vhdl_top_arch;VHDL_TOP_CONFIGURATION;vhdl_top_config;VHDL_TOP_ENTITY;vhdl_top_entity;WORK_LIBRARY;worklib;WORKING_DIRECTORY;/build/CMakeHDL/hello.dir")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
    set(output_file /build/hello.dir/.touch)
endmacro()

macro(CMakeHDL_add_custom_target)
    if(NOT "${ARGN}" STREQUAL "build_hello;ALL;DEPENDS;/build/hello.dir/.touch")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endmacro()

macro(CMakeHDL_search_file_deps output_var)
    if(NOT "${ARGN}" STREQUAL "NAME;hello;VHDL_TOP_CONFIGURATION;vhdl_top_config;VHDL_TOP_ENTITY;vhdl_top_entity;VHDL_TOP_ARCHITECTURE;vhdl_top_arch;WORK_LIBRARY;worklib")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
    set("${output_var}" <file_deps>)
endmacro()

macro(CMakeHDL_add_run_simulation_target)
    if(NOT "${ARGN}" STREQUAL "hello;BUILD_SIMULATION_TARGET;;DEPENDS;;VHDL_TOP_ARCHITECTURE;vhdl_top_arch;VHDL_TOP_CONFIGURATION;vhdl_top_config;VHDL_TOP_ENTITY;vhdl_top_entity;WORK_LIBRARY;worklib;WORKING_DIRECTORY;/build/CMakeHDL/hello.dir")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endmacro()

set(CMAKE_BINARY_DIR /build)
CMakeHDL_add_simulation(
    NAME hello
    VHDL_TOP_CONFIGURATION vhdl_top_config
    VHDL_TOP_ENTITY vhdl_top_entity
    VHDL_TOP_ARCHITECTURE vhdl_top_arch
    WORK_LIBRARY worklib
)