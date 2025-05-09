class ErrorModel {
  final String message;
  final String error;
  final int statusCode;

  ErrorModel({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'] ?? 'Unknown error',
      error: json['error'] ?? 'Unknown error',
      statusCode: json['statusCode'] ?? 0,
    );
  }
}
