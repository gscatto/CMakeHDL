set(CMakeHDL_VHDL_STANDARD 2008)
set(CMakeHDLGhdlLlvm_EXECUTABLE "/usr/bin/ghdl-llvm")
include(CMakeHDLGhdlLlvm)
function(CMakeHDL_add_custom_command)
    if(NOT ARGN STREQUAL "OUTPUT;/build/.touch;COMMAND;/usr/bin/ghdl-llvm;-a;--std=08;--work=hello;/sources;COMMAND;/usr/bin/cmake;-E;touch;/build/.touch;WORKING_DIRECTORY;/build;DEPENDS;/file_deps;COMMENT;Building HDL library hello...")
        message(FATAL_ERROR "unexpected ARGN, got: ${ARGN}")
    endif()
endfunction()
CMakeHDL_add_build_library_command(hello
    WORKING_DIRECTORY /build
    DEPENDS /file_deps
    OUTPUT_FILE_VARIABLE output_file
    SOURCES /sources
)
if(NOT output_file STREQUAL /build/.touch)
    message(FATAL_ERROR "unexpected output_file, got: ${output_file}")
endif()