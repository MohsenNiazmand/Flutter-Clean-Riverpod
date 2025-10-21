import 'package:flutter_clean_riverpod/shared/data/model/post_model.dart';

class AuthResponse {
  AuthResponse({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.userId,
    this.postModel,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: json['expires_in'] as int,
      userId: json['user_id'] as String,
      postModel: (json['postModel'] is Map<String, dynamic>? &&
              json['postModel'] != null)
          ? PostModel.fromJson(json['postModel'] as Map<String, dynamic>)
          : null,
    );
  }

  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;
  final String? userId;
  final PostModel? postModel;

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'user_id': userId,
      'postModel': postModel,
    };
  }
}
