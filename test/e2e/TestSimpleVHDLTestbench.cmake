include(ConfigureAndBuild)

execute_process(
    COMMAND "${CMAKE_COMMAND}" --build "${binary_dir}" --target and_gate_tb_sim
    RESULT_VARIABLE result
    OUTPUT_VARIABLE output
    ERROR_VARIABLE error
)

if(NOT "${result}" STREQUAL "0")
    message(FATAL_ERROR "testbench error")
endif()

if("${output}${error}" MATCHES "failed")
    message(FATAL_ERROR "testbench error")
endif()