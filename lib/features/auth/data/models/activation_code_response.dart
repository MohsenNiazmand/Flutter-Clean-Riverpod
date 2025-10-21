class ActivationTokenResponse {
  ActivationTokenResponse({
    this.code,
  });

  ActivationTokenResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?;
  final String? code;

  Map<String, dynamic> toJson() => {'code': code};
}
