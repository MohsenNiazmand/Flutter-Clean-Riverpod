class ActivationTokenResponse {
  ActivationTokenResponse({
    this.code,
    this.message,
  });

  ActivationTokenResponse.fromJson(Map<String, dynamic> json)
      : code = json['activation_code'] as String?,
        message = json['message'] as String?;
  final String? code;
  final String? message;

  Map<String, dynamic> toJson() => {
        'activation_code': code,
        'message': message,
      };
}
