import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';

class AllNotesModel {

  AllNotesModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  AllNotesModel.fromJson(Map<String, dynamic> json)
      : count = json['count'] as int?,
        next = json['next'],
        previous = json['previous'],
        results = (json['results'] as List?)
            ?.map((dynamic e) => NoteModel.fromJson(e as Map<String, dynamic>))
            .toList();

  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<NoteModel>? results;

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results?.map((e) => e.toJson()).toList()
      };
}
