class Tokens {

  Tokens({
    this.access,
    this.refresh,
  });

  Tokens.fromJson(Map<String, dynamic> json)
      : access = json['access'] as String?,
        refresh = json['refresh'] as String?;
  final String? access;
  final String? refresh;

  Map<String, dynamic> toJson() => {
    'access' : access,
    'refresh' : refresh
  };
}
