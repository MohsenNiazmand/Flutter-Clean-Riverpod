import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/features/home/presentation/widgets/note_item.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter_clean_riverpod/shared/presentation/providers/note_provider.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_max_width.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoteGrid extends ConsumerWidget {
  const NoteGrid({
    super.key,
    required this.notes,
  });

  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = context.deviceType;
    final crossAxisCount = _getCrossAxisCount(deviceType);

    return PrimaryMaxWidth(
      child: MasonryGridView.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: notes.length,
        padding: const EdgeInsets.all(dimen8),
        itemBuilder: (context, index) => NoteItem(
          note: notes[index],
          onNoteSelected: () {
            ref.read(selectedNoteProvider.notifier).state = notes[index];
          },
        ),
      ),
    );
  }

  int _getCrossAxisCount(DeviceTypeEnum deviceType) {
    switch (deviceType) {
      case DeviceTypeEnum.mobile:
        return 2;
      case DeviceTypeEnum.tablet:
        return 3;
      case DeviceTypeEnum.desktop:
        return 4;
    }
  }
}
