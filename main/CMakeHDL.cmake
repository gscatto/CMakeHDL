function(CMakeHDL_add_library)
    cmake_parse_arguments(args "VHDL_RELAXED_RULES" "NAME" "" ${ARGN})
    if(NOT args_NAME)
        message(FATAL_ERROR "CMakeHDL_add_library called without NAME parameter")
    endif()
    set(working_directory "${CMAKE_BINARY_DIR}/CMakeHDL/${args_NAME}.dir")
    CMakeHDL_file(MAKE_DIRECTORY "${working_directory}")
    CMakeHDL_search_sources(sources ${ARGN})
    CMakeHDL_search_file_deps(file_deps ${ARGN})
    CMakeHDL_add_build_library_command(${args_NAME}
        VHDL_RELAXED_RULES "${args_VHDL_RELAXED_RULES}"
        DEPENDS ${file_deps}
        OUTPUT_FILE_VARIABLE output_file
        SOURCES ${sources}
        WORKING_DIRECTORY "${working_directory}"
    )
    CMakeHDL_add_custom_target("${args_NAME}" DEPENDS "${output_file}")
    list(JOIN sources "\\;" sources)
    CMakeHDL_set_target_properties("${args_NAME}"
        PROPERTIES
            CMakeHDL_LIBRARY TRUE
            OUTPUT_FILE "${output_file}"
            SOURCES "${sources}"
            WORKING_DIRECTORY "${working_directory}"
    )
endfunction()

function(CMakeHDL_add_simulation)
    cmake_parse_arguments(args "USES_TERMINAL;VHDL_RELAXED_RULES" "NAME;VHDL_TOP_CONFIGURATION;VHDL_TOP_ENTITY;VHDL_TOP_ARCHITECTURE;WORK_LIBRARY" "" ${ARGN})
    if(NOT args_NAME)
        message(FATAL_ERROR "CMakeHDL_add_simulation called without NAME parameter")
    endif()
    set(working_directory "${CMAKE_BINARY_DIR}/CMakeHDL/${args_NAME}.dir")
    CMakeHDL_file(MAKE_DIRECTORY "${working_directory}")
    CMakeHDL_search_file_deps(file_deps ${ARGN})
    CMakeHDL_add_build_simulation_command(${args_NAME}
        VHDL_RELAXED_RULES "${args_VHDL_RELAXED_RULES}"
        DEPENDS ${file_deps}
        OUTPUT_FILE_VARIABLE build_output_file
        VHDL_TOP_ARCHITECTURE "${args_VHDL_TOP_ARCHITECTURE}"
        VHDL_TOP_CONFIGURATION "${args_VHDL_TOP_CONFIGURATION}"
        VHDL_TOP_ENTITY "${args_VHDL_TOP_ENTITY}"
        WORK_LIBRARY "${args_WORK_LIBRARY}"
        WORKING_DIRECTORY "${working_directory}"
    )
    CMakeHDL_add_run_simulation_target("${args_NAME}"
        USES_TERMINAL "${args_USES_TERMINAL}"
        BUILD_SIMULATION_TARGET "${build_target}"
        DEPENDS "${build_output_file}"
        VHDL_TOP_ARCHITECTURE "${args_VHDL_TOP_ARCHITECTURE}"
        VHDL_TOP_CONFIGURATION "${args_VHDL_TOP_CONFIGURATION}"
        VHDL_TOP_ENTITY "${args_VHDL_TOP_ENTITY}"
        WORK_LIBRARY "${args_WORK_LIBRARY}"
        WORKING_DIRECTORY "${working_directory}"
    )
endfunction()

function(CMakeHDL_search_sources output_var)
    set(sources "")
    cmake_parse_arguments(args "" "" "MERGE_LIBRARIES;SOURCES" ${ARGN})
    CMakeHDL_search_merge_libraries("${args_MERGE_LIBRARIES}" libraries)
    foreach(library IN LISTS libraries)
        CMakeHDL_get_target_property(library_sources "${library}" SOURCES)
        list(APPEND sources ${library_sources})
    endforeach()
    foreach(source IN LISTS args_SOURCES)
        cmake_path(ABSOLUTE_PATH source BASE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
        list(APPEND sources "${source}")
    endforeach()
    set("${output_var}" "${sources}" PARENT_SCOPE)
endfunction()

function(CMakeHDL_search_file_deps output_var)
    cmake_parse_arguments(args "" "WORK_LIBRARY" "" ${ARGN})
    set(file_deps "")
    if(args_WORK_LIBRARY)
        CMakeHDL_get_target_property(output_file "${args_WORK_LIBRARY}" OUTPUT_FILE)
        list(APPEND file_deps "${output_file}")
    endif()
    CMakeHDL_search_sources(sources ${ARGN})
    list(APPEND file_deps ${sources})
    set("${output_var}" "${file_deps}" PARENT_SCOPE)
endfunction()

function(CMakeHDL_search_merge_libraries libraries output_var)
    set(output_val "")
    if(libraries)
        foreach(library IN LISTS libraries)
            CMakeHDL_get_target_property(is_CMakeHDL_library "${library}" CMakeHDL_LIBRARY)
            if(NOT is_CMakeHDL_library)
                continue()
            endif()
            CMakeHDL_get_target_property(library_children "${library}" MERGE_LIBRARIES)
            CMakeHDL_search_merge_libraries("${library_children}" child_output_val)
            list(APPEND output_val ${child_output_val} ${library})
        endforeach()
    endif()
    set("${output_var}" "${output_val}" PARENT_SCOPE)
endfunction()