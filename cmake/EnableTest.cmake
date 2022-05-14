find_package(doctest CONFIG REQUIRED)

if(NOT doctest_FOUND)
  message(FATAL_ERROR "Cannot find doctest package")
  set(_ENABLE_TEST_SUCCESS OFF)
else()
  include(
    ${VCPKG_ROOT}/packages/doctest_${VCPKG_TARGET_TRIPLET}/share/doctest/doctest.cmake
  )
  set(_ENABLE_TEST_SUCCESS ON)
endif()

message(STATUS "_ENABLE_TEST_SUCCESS: ${_ENABLE_TEST_SUCCESS}")

if(_ENABLE_TEST_SUCCESS)
  enable_testing()

  function(add_doctest name)
    message(STATUS "Add test: ${name}")

    add_executable(${name})
    target_sources(${name} PRIVATE ${CMAKE_CURRENT_LIST_DIR}/${name}.cpp)
    target_include_directories(${name} PRIVATE ${CMAKE_CURRENT_LIST_DIR})

    foreach(lib "${ARGN}")
      target_link_libraries(${name} PRIVATE ${lib})
    endforeach()

    target_link_libraries(${name} PRIVATE Compile::CommonSettings
                                          doctest::doctest)

    doctest_discover_tests(${name})
  endfunction()
endif()
