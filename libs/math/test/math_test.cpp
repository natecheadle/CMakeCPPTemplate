#include <gtest/gtest.h>
#include <math_operation.h>

namespace my::math::test {
TEST(MathFixture, ValidateAdd) { ASSERT_EQ(Add(1.0, 2.0), 3.0); }
}  // namespace my::math::test
