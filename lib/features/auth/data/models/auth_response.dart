import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';

class AuthResponse {
  AuthResponse({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.userId,
    this.noteModels,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: json['expires_in'] as int,
      userId: json['user_id'] as String,
      noteModels: json['noteModels'] != null
          ? (json['noteModels'] as List)
              .map((note) => NoteModel.fromJson(note as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;
  final String? userId;
  final List<NoteModel>? noteModels;

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'user_id': userId,
      'noteModels': noteModels?.map((note) => note.toJson()).toList(),
    };
  }
}
