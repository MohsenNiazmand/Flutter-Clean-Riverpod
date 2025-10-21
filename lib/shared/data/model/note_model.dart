import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  NoteModel({
    this.id,
    this.title,
    this.body,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? body;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? body,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
