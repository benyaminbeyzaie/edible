/// for handling exceptions
class CustomException implements Exception {
  final message;

  CustomException(this.message);

  String toString() {
    return "$message";
  }
}
