import 'package:flutter_clean_riverpod/shared/data/model/tokens.dart';
import 'package:flutter_clean_riverpod/shared/data/model/user.dart';

class AuthResponse {

  AuthResponse({
    this.message,
    this.user,
    this.tokens,
  });
  AuthResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        tokens = (json['tokens'] as Map<String, dynamic>?) != null
            ? Tokens.fromJson(json['tokens'] as Map<String, dynamic>)
            : null;

  final String? message;
  final User? user;
  final Tokens? tokens;

  Map<String, dynamic> toJson() =>
      {'message': message, 'user': user?.toJson(), 'tokens': tokens?.toJson()};
}
