cmake_minimum_required(VERSION 3.31.6)
project(TestSimpleVHDLTestbench LANGUAGES NONE)

include(FetchContent)
FetchContent_Declare(CMakeHDL SOURCE_DIR "${project_dir}")
FetchContent_MakeAvailable(CMakeHDL)
get_property(CMakeHDL_CMAKE_MODULE_PATH TARGET CMakeHDL PROPERTY CMAKE_MODULE_PATH)
list(APPEND CMAKE_MODULE_PATH "${CMakeHDL_CMAKE_MODULE_PATH}")
include(CMakeHDL)

CMakeHDL_add_library(
    NAME and_gate_tb
    SOURCES
        and_gate.vhd
        and_gate_tb.vhd
)

CMakeHDL_add_simulation(
    NAME and_gate_tb_sim
    WORK_LIBRARY and_gate_tb
    VHDL_TOP_ENTITY and_gate_tb
)