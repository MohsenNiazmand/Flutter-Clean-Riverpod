import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/dialog/delete_note_dialog.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/selected_note_provider.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoteItem extends ConsumerWidget {
  const NoteItem({
    required this.note,
    required this.onNoteSelected,
    super.key,
  });

  final NoteModel note;
  final VoidCallback onNoteSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimaryRectangle(
      onLongPress: () => _showDeleteDialog(context, ref),
      onTap: () => _handleNoteTap(context, ref),
      radius: dimen8,
      padding: const EdgeInsets.all(dimen8),
      defaultShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title ?? '',
            style: AppStyles().styleText_14_600(),
          ),
          Gap.v8(),
          Text(
            note.content ?? '',
            style: AppStyles().styleText_11_400(),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (_) => DeleteNoteDialog(noteModel: note),
    );
  }

  void _handleNoteTap(BuildContext context, WidgetRef ref) {
    ref.read(selectedNoteProvider.notifier).state = note;
    context.push(Routes.addNote);
  }
}
