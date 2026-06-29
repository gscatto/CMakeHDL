include(CMakeHDL)

macro(CMakeHDL_search_merge_libraries libraries output_var)
    set_property(GLOBAL PROPERTY CMakeHDL_search_merge_libraries TRUE)
    if(NOT "${libraries}" STREQUAL "lib1")
        message(FATAL_ERROR "unexpected libraries, got: ${libraries}")
    endif()
    set("${output_var}" "lib1a;lib1")
endmacro()

macro(CMakeHDL_get_target_property output_var target_name property_name)
    if("${target_name}" STREQUAL "lib1")
        set("${output_var}" "/srv/lib1/a.vhd")
    elseif("${target_name}" STREQUAL "lib1a")
        set("${output_var}" "/srv/lib1a/1.vhd;/srv/lib1a/2.vhd")
    else()
        message(FATAL_ERROR "CMakeHDL_get_target_property(${output_var} ${target_name} ${property_name})")
    endif()
endmacro()

set(CMAKE_CURRENT_SOURCE_DIR "/home/user/prj")
CMakeHDL_search_sources(
    sources_var
    MERGE_LIBRARIES
        lib1
    SOURCES
        relative.vhd
        /etc/absolute.vhd
)

get_property(called GLOBAL PROPERTY CMakeHDL_search_merge_libraries SET)
if(NOT called)
    message(FATAL_ERROR "CMakeHDL_search_merge_libraries was not called")
endif()

if(NOT "${sources_var}" STREQUAL "/srv/lib1a/1.vhd;/srv/lib1a/2.vhd;/srv/lib1/a.vhd;/home/user/prj/relative.vhd;/etc/absolute.vhd")
    message(FATAL_ERROR "unexpected sources_var, got: ${sources_var}")
endif()