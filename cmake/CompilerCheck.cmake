# g++
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "7.0")
    message(STATUS "CMAKE_CXX_COMPILER_VERSION: ${CMAKE_CXX_COMPILER_VERSION}")
    message(FATAL_ERROR "\n${CMAKE_PROJECT_NAME} requires g++ at least v7.0")
  endif()
  # clang++
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "6.0")
    message(STATUS "CMAKE_CXX_COMPILER_VERSION: ${CMAKE_CXX_COMPILER_VERSION}")
    message(
      FATAL_ERROR "\n${CMAKE_PROJECT_NAME} requires clang++ at least v6.0")
  endif()
  # AppleClang
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
  if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "8.0")
    message(
      FATAL_ERROR "\n${CMAKE_PROJECT_NAME} requires AppleClang at least v8.0")
  endif()
  # microsoft visual c++
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  if(NOT MSVC_VERSION GREATER_EQUAL 1914)
    message(STATUS "CMAKE_CXX_COMPILER_VERSION: ${CMAKE_CXX_COMPILER_VERSION}")
    message(
      FATAL_ERROR "\n${CMAKE_PROJECT_NAME} requires MSVC++ at least v14.14")
  endif()
else()
  message(
    FATAL_ERROR
      "\n\
    ${CMAKE_PROJECT_NAME} currently supports the following compilers:\n\
        - g++ v7.0 or above\n\
        - clang++ v6.0 or above\n\
        - MSVC++ v19.14 or above\n\
        - AppleClang v8 or above\n\
    ")
endif()
