# Test CMakeHDL_search_merge_libraries()
add_test(NAME CMakeHDL.TestSearchMergeLibsEmpty COMMAND "${CMAKE_COMMAND}" "-DCMAKE_MODULE_PATH=${PROJECT_SOURCE_DIR}/main" -P "${CMAKE_CURRENT_SOURCE_DIR}/TestSearchMergeLibsEmpty.cmake")
add_test(NAME CMakeHDL.TestSearchMergeLibsSingle COMMAND "${CMAKE_COMMAND}" "-DCMAKE_MODULE_PATH=${PROJECT_SOURCE_DIR}/main" -P "${CMAKE_CURRENT_SOURCE_DIR}/TestSearchMergeLibsSingle.cmake")

# Test CMakeHDL_add_library()
add_test(NAME CMakeHDL.TestAddLibWithoutArgs COMMAND "${CMAKE_COMMAND}" "-DCMAKE_MODULE_PATH=${PROJECT_SOURCE_DIR}/main" -P "${CMAKE_CURRENT_SOURCE_DIR}/TestAddLibWithoutArgs.cmake")
set_property(TEST CMakeHDL.TestAddLibWithoutArgs PROPERTY PASS_REGULAR_EXPRESSION "CMakeHDL_add_library called without NAME parameter")
add_test(NAME CMakeHDL.TestAddLibWithNameOnly COMMAND "${CMAKE_COMMAND}" "-DCMAKE_MODULE_PATH=${PROJECT_SOURCE_DIR}/main" -P "${CMAKE_CURRENT_SOURCE_DIR}/TestAddLibWithNameOnly.cmake")
add_test(NAME CMakeHDL.TestAddLibWithSources COMMAND "${CMAKE_COMMAND}" "-DCMAKE_MODULE_PATH=${PROJECT_SOURCE_DIR}/main" -P "${CMAKE_CURRENT_SOURCE_DIR}/TestAddLibWithSources.cmake")

# Test CMakeHDL_add_simulation()
add_test(NAME CMakeHDL.TestAddSimWithoutArgs COMMAND "${CMAKE_COMMAND}" "-DCMAKE_MODULE_PATH=${PROJECT_SOURCE_DIR}/main" -P "${CMAKE_CURRENT_SOURCE_DIR}/TestAddSimWithoutArgs.cmake")
set_property(TEST CMakeHDL.TestAddSimWithoutArgs PROPERTY PASS_REGULAR_EXPRESSION "CMakeHDL_add_simulation called without NAME parameter")
add_test(NAME CMakeHDL.TestAddSim COMMAND "${CMAKE_COMMAND}" "-DCMAKE_MODULE_PATH=${PROJECT_SOURCE_DIR}/main" -P "${CMAKE_CURRENT_SOURCE_DIR}/TestAddSim.cmake")

# Test CMakeHDL_search_sources()
add_test(NAME CMakeHDL.TestSearchSources COMMAND "${CMAKE_COMMAND}" "-DCMAKE_MODULE_PATH=${PROJECT_SOURCE_DIR}/main" -P "${CMAKE_CURRENT_SOURCE_DIR}/TestSearchSources.cmake")

# Test CMakeHDL_search_file_deps()
add_test(NAME CMakeHDL.TestSearchFileDeps COMMAND "${CMAKE_COMMAND}" "-DCMAKE_MODULE_PATH=${PROJECT_SOURCE_DIR}/main" -P "${CMAKE_CURRENT_SOURCE_DIR}/TestSearchFileDeps.cmake")