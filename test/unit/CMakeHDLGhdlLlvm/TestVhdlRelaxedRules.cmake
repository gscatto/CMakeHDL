set(CMakeHDL_VHDL_STANDARD 2008)
set(CMakeHDLGhdlLlvm_EXECUTABLE "/usr/bin/ghdl-llvm")
include(CMakeHDLGhdlLlvm)

function(CMakeHDL_add_custom_command)
    if(NOT ARGN STREQUAL "OUTPUT;/build/.touch;COMMAND;/usr/bin/ghdl-llvm;-a;--std=08;-frelaxed;--work=hello;COMMAND;/usr/bin/cmake;-E;touch;/build/.touch;WORKING_DIRECTORY;/build;DEPENDS;/file_deps;COMMENT;Building HDL library hello...")
        message(SEND_ERROR "unexpected ARGN, got: ${ARGN}")
        set_property(GLOBAL PROPERTY error TRUE)
    endif()
endfunction()

CMakeHDL_add_build_library_command(hello
    DEPENDS /file_deps
    OUTPUT_FILE_VARIABLE output_file
    WORKING_DIRECTORY /build
    VHDL_RELAXED_RULES ON
)

function(CMakeHDL_add_custom_command)
    if(NOT ARGN STREQUAL "OUTPUT;/build/.touch;COMMAND;/usr/bin/ghdl-llvm;-e;--std=08;-frelaxed;COMMAND;/usr/bin/cmake;-E;touch;/build/.touch;WORKING_DIRECTORY;/build;COMMENT;Building HDL simulation hello...;DEPENDS;/file_deps")
        message(SEND_ERROR "unexpected ARGN, got: ${ARGN}")
        set_property(GLOBAL PROPERTY error TRUE)
    endif()
endfunction()

CMakeHDL_add_build_simulation_command(hello
    DEPENDS /file_deps
    OUTPUT_FILE_VARIABLE output_file
    SOURCES /sources
    VHDL_RELAXED_RULES
    WORKING_DIRECTORY /build
)

CMakeHDL_add_build_simulation_command(hello
    DEPENDS /file_deps
    OUTPUT_FILE_VARIABLE output_file
    SOURCES /sources
    VHDL_RELAXED_RULES
    WORKING_DIRECTORY /build
)