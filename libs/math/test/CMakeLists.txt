cmake_minimum_required(VERSION 3.21)

include(GoogleTest)
include(CopyDlls)
include(GenerateCoverage)
include(GenerateTestReport)

set(CMAKE_CXX_STANDARD 20)

add_executable(${PROJECT_NAME}-test "main.cpp" "math_test.cpp")

find_package(GTest CONFIG REQUIRED)

target_link_libraries(${PROJECT_NAME}-test PRIVATE GTest::gtest ${PROJECT_NAME})
copy_dlls(${PROJECT_NAME}-test)

gtest_add_tests(TARGET ${PROJECT_NAME}-test)

generate_test_report(${PROJECT_NAME}-test)

if(${BUILD_COVERAGE})
  generate_lcov_data(${PROJECT_NAME}-test)
endif()

if(WIN32)
  install(
    TARGETS ${PROJECT_NAME}-test
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION bin)
else()
  install(
    TARGETS ${PROJECT_NAME}-test
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib)
endif()
