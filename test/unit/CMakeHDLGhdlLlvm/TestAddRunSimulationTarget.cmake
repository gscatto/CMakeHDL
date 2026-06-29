set(CMakeHDL_VHDL_STANDARD 2008)
set(CMakeHDLGhdlLlvm_EXECUTABLE "/usr/bin/ghdl-llvm")
include(CMakeHDLGhdlLlvm)

macro(CMakeHDL_get_target_property output_var target_name property_name)
    if(NOT "${target_name};${property_name}" STREQUAL "worklib;WORKING_DIRECTORY")
        message(FATAL_ERROR "unexpected target_name=${target_name} and property_name=${property_name}")
    endif()
    set("${output_var}" "/path/to/worklib")
endmacro()

function(CMakeHDL_add_custom_target)
    if(NOT ARGN STREQUAL "hello;COMMAND;/usr/bin/ghdl-llvm;-r;--std=08;--work=worklib;--workdir=/path/to/worklib;vhdl_top_config;vhdl_top_entity;vhdl_top_arch;WORKING_DIRECTORY;/path/to/workdir;COMMENT;Running HDL simulation hello...;DEPENDS;")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endfunction()

CMakeHDL_add_run_simulation_target(hello
    BUILD_SIMULATION_TARGET build_sim
    VHDL_TOP_ARCHITECTURE vhdl_top_arch
    VHDL_TOP_CONFIGURATION vhdl_top_config
    VHDL_TOP_ENTITY vhdl_top_entity
    WORK_LIBRARY worklib
    WORKING_DIRECTORY /path/to/workdir
)