cmake_minimum_required(VERSION 3.23)

set(CMAKE_VERBOSE_MAKEFILE ON)

message(STATUS "CMAKE_ROOT: " ${CMAKE_ROOT})
message(STATUS "CMAKE_VERSION: " ${CMAKE_VERSION})

if(${CMAKE_VERSION} VERSION_LESS 3.23)
  cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
else()
  cmake_policy(VERSION 3.23)
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# Vcpkg boostrap, must before project()
include(VcpkgBootstrap)

list(APPEND VCPKG_MANIFEST_FEATURES "tests")

project(CPPDPP LANGUAGES CXX)

# Set build type
set(CPPDPP_BUILD_TYPE "Debug")

# Include additional language check
include(CheckLanguage)

# Adhere to GNU conventions
include(GNUInstallDirs)

# Check compiler
include(CompilerCheck)

# Check build type
include(BuildTypeCheck)

# comile settings
include(CompileSettings)

message(STATUS "PROJECT_NAME: " ${PROJECT_NAME})
message(STATUS "CMAKE_HOST_SYSTEM: ${CMAKE_HOST_SYSTEM}")
message(STATUS "CMAKE_BUILD_TYPE: " ${CMAKE_BUILD_TYPE})
message(STATUS "CMAKE_CXX_COMPILER: " ${CMAKE_CXX_COMPILER})
message(STATUS "CMAKE_CXX_COMPILER_ID: " ${CMAKE_CXX_COMPILER_ID})
message(STATUS "CMAKE_CXX_COMPILER_VERSION: " ${CMAKE_CXX_COMPILER_VERSION})
message(STATUS "CMAKE_CXX_FLAGS: " ${CMAKE_CXX_FLAGS})
message(STATUS "CMAKE_MODULE_PATH: " ${CMAKE_MODULE_PATH})
message(STATUS "CMAKE_CURRENT_SOURCE_DIR: " ${CMAKE_CURRENT_SOURCE_DIR})
message(STATUS "CMAKE_CURRENT_BINARY_DIR: " ${CMAKE_CURRENT_BINARY_DIR})
message(STATUS "CMAKE_CURRENT_LIST_DIR: " ${CMAKE_CURRENT_LIST_DIR})
message(STATUS "CMAKE_EXE_LINKER_FLAGS: " ${CMAKE_EXE_LINKER_FLAGS})
message(STATUS "CMAKE_INSTALL_PREFIX: " ${CMAKE_INSTALL_PREFIX})
message(STATUS "CMAKE_INSTALL_FULL_INCLUDEDIR: "
               ${CMAKE_INSTALL_FULL_INCLUDEDIR})
message(STATUS "CMAKE_INSTALL_FULL_LIBDIR: " ${CMAKE_INSTALL_FULL_LIBDIR})
message(STATUS "CMAKE_INSTALL_INCLUDEDIR: " ${CMAKE_INSTALL_INCLUDEDIR})
message(STATUS "CMAKE_INSTALL_LIBDIR: " ${CMAKE_INSTALL_LIBDIR})
message(STATUS "CMAKE_PREFIX_PATH: " ${CMAKE_PREFIX_PATH})

# add the binary tree to the search path for include files
include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/include)

# -----------------------------------------------------------------------------
# must-have package include
# -----------------------------------------------------------------------------
# Enable test
include(CTest)

add_subdirectory(tests)
