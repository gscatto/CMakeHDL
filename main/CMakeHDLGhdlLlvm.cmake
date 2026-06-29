if(CMakeHDL_VHDL_STANDARD EQUAL 1993)
    set(CMakeHDLGhdlLlvm_VHDL_STANDARD_ARG "--std=93")
elseif(CMakeHDL_VHDL_STANDARD EQUAL 2008)
    set(CMakeHDLGhdlLlvm_VHDL_STANDARD_ARG "--std=08")
else()
    message(FATAL_ERROR "CMakeHDL_VHDL_STANDARD should be one of the following values: 1993, 2008")
endif()

function(CMakeHDL_add_build_library_command library_name)
    cmake_parse_arguments(args "" "DEPENDS;OUTPUT_FILE_VARIABLE;WORKING_DIRECTORY" "SOURCES" ${ARGN})
    set(output_file "${args_WORKING_DIRECTORY}/.touch")
    set(build_args "")
    list(APPEND build_args ${CMakeHDLGhdlLlvm_VHDL_STANDARD_ARG})
    list(APPEND build_args "--work=${library_name}")
    CMakeHDL_add_custom_command(
        OUTPUT "${output_file}"
        COMMAND "${CMakeHDLGhdlLlvm_EXECUTABLE}" -a ${build_args} ${args_SOURCES}
        COMMAND "${CMAKE_COMMAND}" -E touch "${output_file}"
        WORKING_DIRECTORY "${args_WORKING_DIRECTORY}"
        DEPENDS ${args_DEPENDS}
        COMMENT "Building HDL library ${library_name}..."
    )
    set(${args_OUTPUT_FILE_VARIABLE} "${output_file}" PARENT_SCOPE)
endfunction()

function(CMakeHDL_add_build_simulation_command name)
    cmake_parse_arguments(args "" "OUTPUT_FILE_VARIABLE;VHDL_TOP_ARCHITECTURE;VHDL_TOP_CONFIGURATION;VHDL_TOP_ENTITY;WORK_LIBRARY;WORKING_DIRECTORY" "DEPENDS" ${ARGN})
    set(output_file "${args_WORKING_DIRECTORY}/.touch")
    set(elab_unit ${args_VHDL_TOP_CONFIGURATION} ${args_VHDL_TOP_ENTITY} ${args_VHDL_TOP_ARCHITECTURE})
    set(elab_args "")
    list(APPEND elab_args "${CMakeHDLGhdlLlvm_VHDL_STANDARD_ARG}")
    if(args_WORK_LIBRARY)
        list(APPEND elab_args "--work=${args_WORK_LIBRARY}")
        CMakeHDL_get_target_property(workdir "${args_WORK_LIBRARY}" WORKING_DIRECTORY)
        list(APPEND elab_args "--workdir=${workdir}")
    endif()
    CMakeHDL_add_custom_command(
        OUTPUT "${output_file}"
        COMMAND "${CMakeHDLGhdlLlvm_EXECUTABLE}" -e ${elab_args} ${elab_unit}
        COMMAND "${CMAKE_COMMAND}" -E touch "${output_file}"
        WORKING_DIRECTORY "${args_WORKING_DIRECTORY}"
        COMMENT "Building HDL simulation ${name}..."
        DEPENDS ${args_DEPENDS}
    )
    set("${args_OUTPUT_FILE_VARIABLE}" "${output_file}" PARENT_SCOPE)
endfunction()

function(CMakeHDL_add_run_simulation_target name)
    cmake_parse_arguments(args "" "BUILD_SIMULATION_TARGET;DEPENDS;VHDL_TOP_ARCHITECTURE;VHDL_TOP_CONFIGURATION;VHDL_TOP_ENTITY;WORK_LIBRARY;WORKING_DIRECTORY" "" ${ARGN})
    set(elab_unit ${args_VHDL_TOP_CONFIGURATION} ${args_VHDL_TOP_ENTITY} ${args_VHDL_TOP_ARCHITECTURE})
    set(elab_args "")
    list(APPEND elab_args "${CMakeHDLGhdlLlvm_VHDL_STANDARD_ARG}")
    if(args_WORK_LIBRARY)
        list(APPEND elab_args "--work=${args_WORK_LIBRARY}")
        CMakeHDL_get_target_property(workdir "${args_WORK_LIBRARY}" WORKING_DIRECTORY)
        list(APPEND elab_args "--workdir=${workdir}")
    endif()
    CMakeHDL_add_custom_target("${name}"
        COMMAND "${CMakeHDLGhdlLlvm_EXECUTABLE}" -r ${elab_args} ${elab_unit}
        WORKING_DIRECTORY "${args_WORKING_DIRECTORY}"
        COMMENT "Running HDL simulation ${name}..."
        DEPENDS "${args_DEPENDS}"
    )
endfunction()