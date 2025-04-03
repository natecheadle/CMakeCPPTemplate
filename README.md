[![Build Status](https://dev.azure.com/natecheadle/CMakeCPPTemplate/_apis/build/status%2Fnatecheadle.CMakeCPPTemplate?branchName=main)](https://dev.azure.com/natecheadle/CMakeCPPTemplate/_build/latest?definitionId=2&branchName=main)
![Azure DevOps coverage](https://img.shields.io/azure-devops/coverage/natecheadle/CMakeCPPTemplate/2)

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