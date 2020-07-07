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