class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({this.message = "Something went wrong!", this.statusCode});
}
