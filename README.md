[![Build and Test](https://github.com/natecheadle/CMakeCPPTemplate/actions/workflows/ci.yml/badge.svg)](https://github.com/natecheadle/CMakeCPPTemplate/actions/workflows/ci.yml)

[![codecov](https://codecov.io/gh/natecheadle/CMakeCPPTemplate/graph/badge.svg?token=XY5QkDOfyX)](https://codecov.io/gh/natecheadle/CMakeCPPTemplate)

# Introduction
This is a template project for starting a new cmake project. 

It includes the following:
1. CMake based project for a library, app, and test binaries
2. A basic CI script for building on Windows with MSVC and Linux with specific LLVM and GCC versions
3. A clang-format file initialized from the Google template
4. A vcpkg.json file for easy integration of cmake/cpp packages

# Quickstart
1. Clone the project into a new folder
2. Delete .git folder
3. Rename folder to new project name
4. Initialize new git repo (`git init`)
5. Set VCPKG_ROOT Environmental variable