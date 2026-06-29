file(REMOVE_RECURSE "${binary_dir}")
file(MAKE_DIRECTORY "${binary_dir}")
execute_process(
    COMMAND "${CMAKE_COMMAND}" -S "${source_dir}" -B "${binary_dir}" "-Dproject_dir=${project_dir}" "-DCMakeHDL_PROGRAM_NAME=${CMakeHDL_PROGRAM_NAME}"
    RESULT_VARIABLE config_result
)
if(NOT "${config_result}" STREQUAL "0")
    message(FATAL_ERROR "configure error")
endif()
execute_process(
    COMMAND "${CMAKE_COMMAND}" --build "${binary_dir}"
    RESULT_VARIABLE build_result
)
if(NOT "${build_result}" STREQUAL "0")
    message(FATAL_ERROR "build error")
endif()