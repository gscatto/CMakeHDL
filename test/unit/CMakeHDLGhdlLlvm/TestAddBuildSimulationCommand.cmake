set(CMakeHDL_VHDL_STANDARD 2008)
set(CMakeHDLGhdlLlvm_EXECUTABLE "/usr/bin/ghdl-llvm")
include(CMakeHDLGhdlLlvm)

function(CMakeHDL_add_custom_command)
    set_property(GLOBAL PROPERTY CMakeHDL_add_custom_command TRUE)
    if(NOT ARGN STREQUAL "OUTPUT;/build/.touch;COMMAND;/usr/bin/ghdl-llvm;-e;--std=08;COMMAND;/usr/bin/cmake;-E;touch;/build/.touch;WORKING_DIRECTORY;/build;COMMENT;Building HDL simulation hello...;DEPENDS;/file_deps")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endfunction()

CMakeHDL_add_build_simulation_command(hello
    WORKING_DIRECTORY /build
    DEPENDS /file_deps
    OUTPUT_FILE_VARIABLE output_file
    SOURCES /sources
)

get_property(called GLOBAL PROPERTY CMakeHDL_add_custom_command SET)
if(NOT called)
    message(FATAL_ERROR "CMakeHDL_add_custom_command was not called")
endif()

if(NOT output_file STREQUAL /build/.touch)
    message(FATAL_ERROR "unexpected output_file, got: ${output_file}")
endif()