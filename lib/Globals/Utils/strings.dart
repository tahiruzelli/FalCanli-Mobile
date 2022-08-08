String dropLastCharacter(String string) {
  String str = string;
  if (str.isNotEmpty) {
    str = str.substring(0, str.length - 1);
  }
  return str;
}
