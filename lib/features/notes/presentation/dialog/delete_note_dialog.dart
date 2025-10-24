import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/delete_note_provider.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_button.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_dialog.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteNoteDialog extends HookConsumerWidget {
  const DeleteNoteDialog({
    required this.noteModel,
    super.key,
  });

  final NoteModel noteModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = context.deviceType;

    return PrimaryDialog(
      width: deviceType == DeviceTypeEnum.mobile
          ? MediaQuery.sizeOf(context).width - dimen72
          : dimen512,
      height: dimen152,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.tr.deleteNoteConfirmation,
            style: AppStyles().styleText_12_500(),
          ),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  type: ButtonType.secondary,
                  onPress: () {
                    context.pop();
                  },
                  text: context.tr.cancel,
                ),
              ),
              Gap.h8(),
              Expanded(
                child: PrimaryButton(
                  onPress: () {
                    ref
                        .read(deleteNoteProvider.notifier)
                        .deleteNote(noteModel.id ?? 0);
                    context.pop();
                  },
                  text: context.tr.delete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
