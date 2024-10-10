cmake_minimum_required(VERSION 3.21)

set(CMAKE_CXX_STANDARD 20)

add_library(${PROJECT_NAME} STATIC "string_operation.cpp")

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_LIST_DIR})

if(WIN32)
  install(
    TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION bin)
else()
  install(
    TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib)
endif()
