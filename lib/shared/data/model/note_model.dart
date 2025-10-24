import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  NoteModel({
    this.id,
    this.title,
    this.content,
    this.userId,
    this.userEmail,
    this.userFullName,
    this.createdAt,
    this.updatedAt,
    this.isArchived,
    this.isFavorite,
    this.color,
    this.excerpt,
    this.wordCount,
    this.ageInDays,
    this.isRecent,
  });

  NoteModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        content = json['content'] as String?,
        userId = json['user_id'] as int?,
        userEmail = json['user_email'] as String?,
        userFullName = json['user_full_name'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        isArchived = json['is_archived'] as bool?,
        isFavorite = json['is_favorite'] as bool?,
        color = json['color'] as String?,
        excerpt = json['excerpt'] as String?,
        wordCount = json['word_count'] as int?,
        ageInDays = json['age_in_days'] as int?,
        isRecent = json['is_recent'] as bool?;

  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? content;

  @HiveField(3)
  final int? userId;

  @HiveField(4)
  final String? userEmail;

  @HiveField(5)
  final String? userFullName;

  @HiveField(6)
  final String? createdAt;

  @HiveField(7)
  final String? updatedAt;

  @HiveField(8)
  final bool? isArchived;

  @HiveField(9)
  final bool? isFavorite;

  @HiveField(10)
  final String? color;

  @HiveField(11)
  final String? excerpt;

  @HiveField(12)
  final int? wordCount;

  @HiveField(13)
  final int? ageInDays;

  @HiveField(14)
  final bool? isRecent;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'user_id': userId,
    'user_email': userEmail,
    'user_full_name': userFullName,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'is_archived': isArchived,
    'is_favorite': isFavorite,
    'color': color,
    'excerpt': excerpt,
    'word_count': wordCount,
    'age_in_days': ageInDays,
    'is_recent': isRecent,
  };

  NoteModel copyWith({
    int? id,
    String? title,
    String? content,
    int? userId,
    String? userEmail,
    String? userFullName,
    String? createdAt,
    String? updatedAt,
    bool? isArchived,
    bool? isFavorite,
    String? color,
    String? excerpt,
    int? wordCount,
    int? ageInDays,
    bool? isRecent,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      userFullName: userFullName ?? this.userFullName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
      isFavorite: isFavorite ?? this.isFavorite,
      color: color ?? this.color,
      excerpt: excerpt ?? this.excerpt,
      wordCount: wordCount ?? this.wordCount,
      ageInDays: ageInDays ?? this.ageInDays,
      isRecent: isRecent ?? this.isRecent,
    );
  }
}