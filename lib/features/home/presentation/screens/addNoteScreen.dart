import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/providers/note_provider.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_button.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_max_width.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_textfield.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddNoteScreen extends HookConsumerWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedNote = ref.watch(selectedNoteProvider);

    final focus = useFocusNode();

    useEffect((){
      SchedulerBinding.instance.addPostFrameCallback((_){
        if(selectedNote!=null){
          titleController.text=selectedNote.title??'';
          descriptionController.text=selectedNote.body??'';
        }
      });
      return null;
    },[],);

    return Scaffold(
      backgroundColor: cBackground,
      body: Padding(
        padding: const EdgeInsets.all(dimen16),
        child: Center(
          child: PrimaryMaxWidth(
            child: FormBuilder(
              key: GlobalKeys.addNoteFormKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PrimaryTextField(
                            controller: titleController,
                            hint: context.tr.title,
                            name: context.tr.title,
                            maxLines: 1,
                            hintStyle: AppStyles()
                                .styleText_14_500()
                                .apply(color: cPPlaceHolder),
                            enabledBorder: InputBorder.none,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: cPrimary50)),
                            cursorColor: cPrimary,
                            filled: false,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(focus);
                            },
                          ),
                          Gap.v12(),
                          PrimaryTextField(
                            controller: descriptionController,
                            hint: context.tr.description,
                            name: context.tr.description,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            focusNode: focus,
                            cursorColor: cPrimary,
                            maxLines: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap.v12(),
                  PrimaryButton(
                    width: double.infinity,
                    onPress: () {
                      if (selectedNote == null) {
                        ref.read(notesProvider.notifier).saveNote(
                              title: titleController.text,
                              body: descriptionController.text,
                            );
                      } else {
                        final nNoteModel = NoteModel(
                          id: selectedNote.id,
                          title: titleController.text,
                          body: descriptionController.text,
                        );
                        ref.read(notesProvider.notifier).updateNote(nNoteModel);
                      }
                      context.pop();
                    },
                    text: context.tr.save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
