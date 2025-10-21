import 'package:flutter_clean_riverpod/core/utils/logger_helper.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:hive/hive.dart';

class DatabaseHelper {
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static const String noteBoxName = 'noteBox';
  static const String metaBoxName = 'metaBox';
  static const String noteIdKey = 'lastNoteId';

  Future<Box<NoteModel>> get noteBox async =>
      Hive.openBox<NoteModel>(noteBoxName);

  Future<Box> get metaBox async => Hive.openBox(metaBoxName);

  Future<int> _getNextId() async {
    final box = await metaBox;
    final currentId = box.get(noteIdKey, defaultValue: 0) as int;
    final nextId = currentId + 1;
    await box.put(noteIdKey, nextId);
    return nextId;
  }

  Future<void> insertNote({
    required String title,
    required String body,
  }) async {
    try {
      final box = await noteBox;
      final nextId = await _getNextId();

      final newNote = NoteModel(
        id: nextId,
        title: title,
        body: body,
      );

      await box.put(nextId, newNote);
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
  }

  Future<void> insertAllNotes(List<NoteModel> notes) async {
    try {
      final box = await noteBox;
      final meta = await metaBox;
      var currentId = meta.get(noteIdKey, defaultValue: 0) as int;

      final Map<int, NoteModel> noteMap = {};

      for (var note in notes) {
        currentId++;
        noteMap[currentId] = note.copyWith(id: currentId);
      }

      await box.putAll(noteMap);
      await meta.put(noteIdKey, currentId);
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
  }

  Future<List<NoteModel>> getNotes() async {
    try {
      final box = await noteBox;
      return box.values
          .whereType<NoteModel>()
          .where((n) => n.id != null)
          .toList();
    } catch (e) {
      LoggerHelper.errorLog(e);
      return [];
    }
  }

  Future<NoteModel?> getNoteById(int id) async {
    try {
      final box = await noteBox;
      return box.get(id);
    } catch (e) {
      LoggerHelper.errorLog(e);
      return null;
    }
  }

  Future<void> updateNote(NoteModel noteModel) async {
    try {
      if (noteModel.id == null) throw Exception('Note ID is null');
      final box = await noteBox;
      await box.put(noteModel.id, noteModel);
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
  }

  Future<void> deleteNoteById(int id) async {
    try {
      final box = await noteBox;
      await box.delete(id);
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
  }

  Future<void> deleteAllNotes() async {
    try {
      final box = await noteBox;
      final meta = await metaBox;

      await box.clear();
      await meta.put(noteIdKey, 0);
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
  }
}
