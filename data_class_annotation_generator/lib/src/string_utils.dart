// Copyright (c) 2017, Ltei. All rights reserved.
// Use of this source code is governed by a MIT license that can be found in the
// LICENSE file.

/// Misc methods for String manipulation.
class StringUtils {
  static String decapitalize(String str) {
    if (str.isEmpty) {
      return "";
    } else if (str.length == 1) {
      return str.toLowerCase();
    } else {
      return str[0].toLowerCase() + str.substring(1, str.length);
    }
  }

  static String capitalize(String str) {
    if (str.isEmpty) {
      return "";
    } else if (str.length == 1) {
      return str.toUpperCase();
    } else {
      return str[0].toUpperCase() + str.substring(1, str.length);
    }
  }
}
