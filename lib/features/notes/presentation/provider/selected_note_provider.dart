import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedNoteProvider = StateProvider<NoteModel?>((ref) => null);
