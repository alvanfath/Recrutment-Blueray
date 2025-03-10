class SuccessModel {
  final bool action;
  final bool? valid;
  final dynamic status;
  final String message;
  final dynamic data;
  final dynamic result;
  final String? imageUrl;

  SuccessModel({
    this.action = false,
    this.valid,
    required this.status,
    required this.message,
    required this.data,
    required this.result,
    required this.imageUrl,
  });

  factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(
      action: json['action'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'],
      result: json['result'],
      valid: json['valid'],
      imageUrl: json['image_url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'status': status,
      'message': message,
      'data': data,
      'result': result,
      'image_url': imageUrl,
    };
  }
}
