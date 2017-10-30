#define CATCH_CONFIG_MAIN

#include "nsfw/transforms/ExcludeDirectories.h"
#include "catch.hpp"

using namespace NSFW;

TEST_CASE("directories can be excluded", "[ExcludeDirectories]") {
  VecEvents vec(new std::vector<VecEvents::element_type::value_type>());

  SECTION("exclude directory name") {
    std::string regex = "/bar$";
    ExcludeDirectories exDir(regex);

    SECTION("directory name does not match") {
      vec->emplace_back(new Event(EventType::CREATED, "/usr/foo", "", ""));
      vec->emplace_back(new Event(EventType::CREATED, "/bar/usr", "", ""));

      auto transformed = exDir(std::move(vec));
      REQUIRE(transformed->size() == 2);
    }

    SECTION("one directory name does and another not match") {
      vec->emplace_back(new Event(EventType::CREATED, "/usr/foo", "", ""));
      vec->emplace_back(new Event(EventType::CREATED, "/bar/bar", "", ""));

      auto transformed = exDir(std::move(vec));
      REQUIRE(transformed->size() == 1);
    }

    SECTION("directory name matches the regular expression") {
      vec->emplace_back(new Event(EventType::CREATED, "/usr/bar", "", ""));
      auto transformed = exDir(std::move(vec));
      REQUIRE(transformed->size() == 0);
    }

    SECTION("all directories ends with bar") {
      vec->emplace_back(new Event(EventType::CREATED, "/a/bar", "", ""));
      vec->emplace_back(new Event(EventType::CREATED, "/b/bar", "", ""));
      vec->emplace_back(new Event(EventType::CREATED, "/c/bar", "", ""));
      auto transformed = exDir(std::move(vec));
      REQUIRE(transformed->size() == 0);
    }
  }
}
