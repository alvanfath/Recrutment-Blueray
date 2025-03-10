class FailureModel {
  final int? statusCode;
  final String? detail;
  final String? message;
  final dynamic data;

  const FailureModel({
    this.statusCode,
    required this.detail,
    this.message,
    this.data,
  });
}
