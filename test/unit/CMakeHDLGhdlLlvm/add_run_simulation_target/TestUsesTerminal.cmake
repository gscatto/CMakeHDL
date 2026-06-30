set(CMakeHDL_VHDL_STANDARD 1993)
include(CMakeHDLGhdlLlvm)

# Test without USES_TERMINAL

macro(CMakeHDL_add_custom_target)
    if("${ARGN}" MATCHES "USES_TERMINAL")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endmacro()

CMakeHDL_add_run_simulation_target(NAME sim_name USES_TERMINAL FALSE)

# Test with USES_TERMINAL

macro(CMakeHDL_add_custom_target)
    if(NOT "${ARGN}" MATCHES "USES_TERMINAL")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endmacro()

CMakeHDL_add_run_simulation_target(NAME sim_name USES_TERMINAL TRUE)