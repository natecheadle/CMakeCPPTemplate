cmake_minimum_required(VERSION 3.21)

project(my-project)

include(GenerateCoverage)

if(${BUILD_COVERAGE})
  if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    add_compile_options(-coverage)
    add_link_options(-coverage)
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(CLANG_COVERAGE_COMPILE_FLAGS
        "-fprofile-instr-generate -fcoverage-mapping")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CLANG_COVERAGE_COMPILE_FLAGS}")
  endif()
  merge_lcov_data(${PROJECT_NAME}-Coverage TARGETS "my-string-test"
                  "my-math-test")
  generate_html_report(${PROJECT_NAME}-Coverage TARGETS "my-string-test"
                       "my-math-test")
endif()

execute_process(
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    ${CMAKE_BINARY_DIR}/compile_commands.json
    ${CMAKE_SOURCE_DIR}/compile_commands.json)

enable_testing()

add_compile_definitions(PUBLIC $<$<CONFIG:Debug>:DEBUG>)

add_custom_target(${PROJECT_NAME}-Report DEPENDS my-math-test-Report my-string-test-Report)

add_subdirectory("app")
add_subdirectory("libs")
