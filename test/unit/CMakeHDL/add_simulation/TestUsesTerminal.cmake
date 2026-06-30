include(CMakeHDL)

macro(CMakeHDL_file)
endmacro()

macro(CMakeHDL_add_build_simulation_command)
endmacro()

# Test without USES_TERMINAL

macro(CMakeHDL_add_run_simulation_target)
    if(NOT "${ARGN}" MATCHES "USES_TERMINAL;FALSE")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endmacro()

CMakeHDL_add_simulation(NAME sim_name)

# Test with USES_TERMINAL

macro(CMakeHDL_add_run_simulation_target)
    if(NOT "${ARGN}" MATCHES "USES_TERMINAL;TRUE")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endmacro()

CMakeHDL_add_simulation(NAME sim_name USES_TERMINAL)