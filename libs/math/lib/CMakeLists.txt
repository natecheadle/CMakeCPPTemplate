cmake_minimum_required(VERSION 3.21)

set(CMAKE_CXX_STANDARD 20)

add_library(${PROJECT_NAME}-lib STATIC "math_operation.cpp")

target_include_directories(${PROJECT_NAME}-lib PUBLIC ${CMAKE_CURRENT_LIST_DIR})
