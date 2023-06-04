
extension StringExtension on String {
  String titleCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension ExtendedString on String {
  String removeAllWhitespace() {
    return replaceAll(RegExp(r"\s+"), "");
  }
}