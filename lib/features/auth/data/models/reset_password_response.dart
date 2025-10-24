class ResetPasswordResponse {
  ResetPasswordResponse({
    this.resetToken,
    this.message,
  });

  ResetPasswordResponse.fromJson(Map<String, dynamic> json)
      : resetToken = json['reset_token'] as String?,
        message = json['message'] as String?;
  final String? resetToken;
  final String? message;

  Map<String, dynamic> toJson() => {
        'reset_token': resetToken,
        'message': message,
      };
}
