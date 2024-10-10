#include <gtest/gtest.h>
#include <math_operation.h>

namespace my::math::test {
TEST(MathFixture, ValidateAddDouble) { ASSERT_EQ(Add(1.0, 2.0), 3.0); }
TEST(MathFixture, ValidateAddFloat) { ASSERT_EQ(Add(1.0f, 2.0f), 3.0f); }
}  // namespace my::math::test
