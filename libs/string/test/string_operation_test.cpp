#include <gtest/gtest.h>
#include <string_operation.h>

namespace my::string::test {
TEST(string_lib_fixture, validate_to_upper) {
  ASSERT_EQ(ToUpper("hello"), "HELLO");
}
}  // namespace my::string::test
