# CTest is quite slow compared to running the tests directly with GTEST (100x
# slower). This function registers the test report as a build target so we can
# easily build the test report directly from GTest.
function(generate_test_report target)
  add_custom_command(
    OUTPUT ${target}_Report.xml
    COMMENT "Run Tests and Generate Test Report"
    DEPENDS ${target}
    # gather data
    COMMAND ${CMAKE_COMMAND} -E env GTEST_OUTPUT=xml:${target}_Report.xml
            $<TARGET_FILE:${target}>
    COMMAND cmake -E copy ${target}_Report.xml ${CMAKE_BINARY_DIR}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

  add_custom_target(${target}-Report DEPENDS ${target}_Report.xml)
endfunction()