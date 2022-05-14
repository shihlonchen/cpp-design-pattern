/**
 * @file helloworld.cpp
 * @copyright MIT
 */
#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN  // NOLINT
#include <doctest/doctest.h>

#include <string>

auto hello_world() -> std::string { return {"hello world"}; }

TEST_CASE("testing hello world") {
  REQUIRE(hello_world() == std::string("hello world"));  // NOLINT
}
