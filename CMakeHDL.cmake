# Define options
set(CMakeHDL_VHDL_STANDARD 1993 CACHE STRING "VHDL standard")

# Include CMake sources
get_property(CMakeHDL_PROJECT_SOURCE_DIR TARGET CMakeHDL PROPERTY PROJECT_SOURCE_DIR)
include("${CMakeHDL_PROJECT_SOURCE_DIR}/main/CMakeHDL.cmake")

# Include program support
if("${CMakeHDL_PROGRAM_NAME}" STREQUAL "ghdl-llvm")
    find_program(CMakeHDLGhdlLlvm_EXECUTABLE ghdl-llvm REQUIRED)
    include("${CMakeHDL_PROJECT_SOURCE_DIR}/main/CMakeHDLGhdlLlvm.cmake")
endif()

# Implement support functions
macro(CMakeHDL_file)
    file(${ARGN})
endmacro()
macro(CMakeHDL_add_custom_command)
    add_custom_command(${ARGN})
endmacro()
macro(CMakeHDL_add_custom_target)
    add_custom_target(${ARGN})
endmacro()
macro(CMakeHDL_set_target_properties)
    set_target_properties(${ARGN})
endmacro()
macro(CMakeHDL_get_target_property)
    get_target_property(${ARGN})
endmacro()