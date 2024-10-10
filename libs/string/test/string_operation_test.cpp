#include <gtest/gtest.h>
#include <string_operation.h>

namespace my::string::test {
TEST(StringLibFixutre, ValidateToUpper) {
  ASSERT_EQ(ToUpper("hello"), "HELLO");
}
}  // namespace my::string::test
