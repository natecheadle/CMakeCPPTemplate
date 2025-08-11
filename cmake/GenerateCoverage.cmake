function(generate_lcov_data target)

  set(options)
  set(oneValueArgs)
  set(multiValueArgs LIBRARIES)
  cmake_parse_arguments(PARSE_ARGV 1 arg "${options}" "${oneValueArgs}"
                        "${multiValueArgs}")
  if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    # find required tools
    find_program(LCOV lcov REQUIRED)

    # add coverage target
    add_custom_command(
      OUTPUT ${target}.info
      COMMENT "Run Tests and Generate LCOV DATA"
      DEPENDS ${target}
      # gather data
      COMMAND ${target}
      COMMAND
        ${LCOV} --include ${CMAKE_SOURCE_DIR} --exclude ${CMAKE_BINARY_DIR} --exclude
        ${CMAKE_SOURCE_DIR}/*test --branch-coverage --ignore-errors mismatch
        --directory ${CMAKE_BINARY_DIR} ${LCOV_DIRS} --capture --output-file ${CMAKE_BINARY_DIR}/${target}.info
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

    add_custom_target(${target}-Coverage DEPENDS ${target}.info)
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    # find required tools
    find_program(LLVM_PROFDATA llvm-profdata REQUIRED)
    find_program(LLVM_COV llvm-cov REQUIRED)

    foreach(tar ${arg_LIBRARIES})
      list(APPEND LLVM_OBJECTS "-object" "$<TARGET_FILE:${tar}>")
    endforeach()

    # add coverage target
    add_custom_command(
      OUTPUT ${target}.info
      BYPRODUCTS ${target}.profdata ${target}.profraw
      COMMENT "Run Tests and Generate LCOV DATA"
      DEPENDS ${target}
      # gather data
      COMMAND ${CMAKE_COMMAND} -E env "LLVM_PROFILE_FILE=${target}.profraw"
              ./${target}
      COMMAND ${LLVM_PROFDATA} merge -sparse -o ${target}.profdata
              ${target}.profraw
      COMMAND echo ${LLVM_OBJECTS}
      COMMAND
        ${LLVM_COV} export ${target} ${LLVM_OBJECTS} -ignore-filename-regex=.*test.*
        -instr-profile ${target}.profdata -format=lcov >
        ${CMAKE_BINARY_DIR}/${target}.info
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

    add_custom_target(${target}-Coverage DEPENDS ${target}.info)

  endif()
endfunction()

function(merge_lcov_data target)
  set(options)
  set(oneValueArgs)
  set(multiValueArgs TARGETS)
  cmake_parse_arguments(PARSE_ARGV 1 arg "${options}" "${oneValueArgs}"
                        "${multiValueArgs}")

  find_program(LCOV lcov REQUIRED)

  set(LCOV_TARGETS "")
  set(LCOV_DEPENDS "")

  foreach(tar ${arg_TARGETS})
    list(APPEND LCOV_DEPENDS ${tar}-Coverage)
    list(APPEND LCOV_TARGETS "-a" "${tar}.info")
  endforeach()

  add_custom_target(
    ${target}
    COMMENT "Merge LCOV Results"
    DEPENDS ${LCOV_DEPENDS}
    # generate report
    COMMAND ${LCOV} ${LCOV_TARGETS} -o ${target}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
endfunction()

function(generate_html_report target)

  set(options)
  set(oneValueArgs)
  set(multiValueArgs TARGETS)
  cmake_parse_arguments(PARSE_ARGV 1 arg "${options}" "${oneValueArgs}"
                        "${multiValueArgs}")
  find_program(GENHTML genhtml REQUIRED)

  set(LCOV_TARGETS "")
  set(LCOV_DEPENDS "")

  foreach(tar ${arg_TARGETS})
    list(APPEND LCOV_DEPENDS ${tar}-Coverage)
    list(APPEND LCOV_TARGETS ${CMAKE_BINARY_DIR}/${tar}.info)
  endforeach()

  add_custom_target(
    ${target}-HTML
    COMMENT "Generate HTML Coverage Report"
    DEPENDS ${LCOV_DEPENDS}
    # generate report
    COMMAND ${GENHTML} --ignore-errors mismatch --ignore-errors category
            --branch-coverage --demangle-cpp -o ${target}-html ${LCOV_TARGETS}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
endfunction()