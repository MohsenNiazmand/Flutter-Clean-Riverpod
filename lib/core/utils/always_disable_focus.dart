import 'package:flutter/material.dart';

/// A FocusNode that always reports as not having focus.
/// Useful for preventing keyboard focus on specific widgets.
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}