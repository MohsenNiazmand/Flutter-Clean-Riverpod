import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GlobalKeys {
  static final GlobalKey<FormBuilderState> loginFormKey =
      GlobalKey<FormBuilderState>();
  static final GlobalKey<FormBuilderState> forgotPasswordFormKey =
      GlobalKey<FormBuilderState>();
  static final GlobalKey<FormBuilderState> createPasswordFormKey =
      GlobalKey<FormBuilderState>();

  static final GlobalKey<FormBuilderState> registerFormKey =
      GlobalKey<FormBuilderState>();

  static final GlobalKey<FormBuilderState> captchaDialogFormKey =
  GlobalKey<FormBuilderState>();

  static final GlobalKey<FormBuilderState> addNoteFormKey =
  GlobalKey<FormBuilderState>();

  static final drawerKey = GlobalKey<ScaffoldState>();
  static final appbarProfileKey = GlobalKey();
  static final pinPutEmailConfirmationKey = GlobalKey();
}
