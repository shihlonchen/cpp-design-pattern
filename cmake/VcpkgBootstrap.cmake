macro(vcpkg_bootstrap)
  vcpkg_submodule_config()
  vcpkg_submodule_update()
  vcpkg_submodule_set_toolchain()
endmacro()

macro(vcpkg_submodule_config)
  if(NOT DEFINED VCPKG_ROOT)
    # set enviroment variable VCPKG_ROOT=${CMAKE_SOURCE_DIR}/vcpkg
    if(NOT DEFINED ENV{VCPKG_ROOT})
      set(ENV{VCPKG_ROOT} ${CMAKE_SOURCE_DIR}/vcpkg)
    endif()

    # set VCPKG_ROOT from ENV{VCPKG_ROOT}
    set(VCPKG_ROOT $ENV{VCPKG_ROOT})
  endif()
endmacro()

macro(vcpkg_submodule_update)
  if(NOT EXISTS ${VCPKG_ROOT}/.vcpkg-root)
    find_package(Git QUIET)

    if(GIT_FOUND AND EXISTS "${CMAKE_SOURCE_DIR}/.git")
      # Update submodules as needed
      option(_CHECK_GIT_SUBMODULE "Check submodules during build" ON)

      if(_CHECK_GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(
          COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
          WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
          RESULT_VARIABLE _GIT_SUBMOD_RESULT)
        if(NOT _GIT_SUBMOD_RESULT EQUAL "0")
          message(
            FATAL_ERROR
              "git submodule update --init --recursive failed with ${GIT_SUBMOD_RESULT}, please checkout submodules"
          )
        endif()
      endif()
    endif()
  endif()

  if(EXISTS ${VCPKG_ROOT}/.vcpkg-root)
    # The following command has no effect if the vcpkg repository is in a
    # detached head state.
    message(STATUS "Auto-updating vcpkg in ${VCPKG_ROOT}")
    execute_process(COMMAND git pull WORKING_DIRECTORY ${VCPKG_ROOT})
  endif()
endmacro()

macro(vcpkg_submodule_set_toolchain)
  # Find out whether the user supplied their own VCPKG toolchain file
  if(NOT DEFINED ${CMAKE_TOOLCHAIN_FILE})
    set(CMAKE_TOOLCHAIN_FILE
        ${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake
        CACHE STRING "")
  else()
    message(FATAL_ERROR "Do not install vcpkg in: ${VCPKG_ROOT}")
  endif()

  message(STATUS "VCPKG_ROOT:" ${VCPKG_ROOT})
  message(STATUS "CMAKE_TOOLCHAIN_FILE:" ${CMAKE_TOOLCHAIN_FILE})
endmacro()

vcpkg_bootstrap()
