class ApiBasicResponse {
  final bool success;
  final String message;

  ApiBasicResponse({
    required this.success,
    required this.message,
  });

  factory ApiBasicResponse.fromJson(Map<String, dynamic> json) =>
      ApiBasicResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
      );
}