import 'package:flutter/cupertino.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

typedef Validator = String? Function(dynamic param);

/// Collection of form validation utilities for common input validation patterns.
/// Provides validators for password strength, text length, and word count.
class FormValidators {
  static FormFieldValidator<String> minLength(BuildContext context,
      int minLength,
      {String? errorText}) =>
      FormBuilderValidators.minLength(
        minLength,
        errorText: errorText,
      );

  static FormFieldValidator<String> passwordValidator(BuildContext context,
      {String? errorText}) {
    return (value) {
      if (!RegExp(r'[A-Z]').hasMatch(value ?? '')) {
        return errorText ??
            'Password must contain at least one uppercase letter';
      }

      if (!RegExp(r'[&$@!?%#]').hasMatch(value ?? '')) {
        return errorText ??
            r'Password must contain at least one special character (&$@!?%#)';
      }

      return null;
    };
  }


  static FormFieldValidator<String> maxWordsValidator(BuildContext context,
      {int maxWords = 60, String? errorText}) {
    return (value) {
      if (value != null) {
        // Split the input by whitespace and count the words
        final wordCount = value.trim().split(RegExp(r'\s+')).length;
        if (wordCount > maxWords) {
          return errorText ?? 'Maximum $maxWords words allowed';
        }
      }
      return null; // Return null if validation passes
    };
  }
}