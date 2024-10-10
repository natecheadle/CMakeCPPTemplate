#include "string_operation.h"

#include <cctype>

namespace my::string {
std::string ToUpper(std::string value) {
  for (char& val : value) {
    val = toupper(val);
  }
  return value;
}
}  // namespace my::string
