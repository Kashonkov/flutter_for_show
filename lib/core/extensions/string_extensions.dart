extension StringExt on String? {
  bool equalsIgnoreCase(String string) {
    return this?.toLowerCase() == string.toLowerCase();
  }

  bool isNullOrEmpty() => this == null || this!.isEmpty;

  String clearNotDigits(){
    return this!.replaceAll(RegExp(r'\D'), "");
  }
}
