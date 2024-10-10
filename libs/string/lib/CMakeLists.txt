cmake_minimum_required(VERSION 3.21)

set(CMAKE_CXX_STANDARD 20)

add_library(${PROJECT_NAME}-lib STATIC "string_operation.cpp")

target_include_directories(${PROJECT_NAME}-lib PUBLIC ${CMAKE_CURRENT_LIST_DIR})

install(
  TARGETS ${PROJECT_NAME}-lib
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION bin)
