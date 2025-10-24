// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get aboutUs => 'About us';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get contactUs => 'Contact us';

  @override
  String get logout => 'Logout';

  @override
  String get updateProfileImage => 'Update profile image';

  @override
  String get setProfileImage => 'Set profile image';

  @override
  String get loginToAccount => 'Login To Account';

  @override
  String get email => 'Email';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Password must be at least 8 characters';

  @override
  String get passwordInvalid => 'Password is not valid.';

  @override
  String get iForgotMyPassword => 'I forgot my password!';

  @override
  String get login => 'Login';

  @override
  String get doNotHaveAnAccount => 'Don’t have an account?';

  @override
  String get register => 'Register';

  @override
  String get byLoggingInYouAgreeToOur => 'By logging in, you agree to our ';

  @override
  String get emailConfirmation => 'Email confirmation';

  @override
  String emailVerificationDescription(String email) {
    return 'We sent a 6-digit verification code to $email email, Please enter the code';
  }

  @override
  String get toResend => 'to resend';

  @override
  String get incorrectCodePLeaseCheckAndReEnter =>
      'Incorrect code. Please check and re-enter.';

  @override
  String get confirmCode => 'Confirm code';

  @override
  String get didNotReceiveCode => 'Did not receive the code?';

  @override
  String get resend => 'Resend';

  @override
  String get createPassword => 'Create a password';

  @override
  String get newPassword => 'New password';

  @override
  String get repeatPassword => 'Repeat password';

  @override
  String get confirmationToken => 'Confirmation token';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match.';

  @override
  String get confirm => 'Confirm';

  @override
  String get invalidCaptcha => 'Invalid CAPTCHA. Please try again.';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get resetPasswordDescription =>
      'Enter your email and we\'ll send you a link to get back into your account.';

  @override
  String get emailExample => 'tnneu@gmail.com';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get youShouldAcceptTermsToContinue =>
      'You should accept terms to continue';

  @override
  String get captcha => 'captcha';

  @override
  String get createAccount => 'Create an account';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get acceptTermsAndConditions => 'I accept the terms & conditions';

  @override
  String get continueText => 'Continue';

  @override
  String get doYouHaveAnAccount => 'Do you have an account?';

  @override
  String get errorWidgetText => 'Something went wrong. Please try again.';

  @override
  String get isRequired => 'is required';

  @override
  String get saturday => 'SAT';

  @override
  String get sunday => 'SUN';

  @override
  String get monday => 'MON';

  @override
  String get tuesday => 'TUE';

  @override
  String get wednesday => 'WED';

  @override
  String get thursday => 'THU';

  @override
  String get friday => 'FRI';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get save => 'Save';

  @override
  String get deleteNote => 'Delete Note';

  @override
  String get deleteNoteConfirmation =>
      'Are you sure you want to delete this note?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get passwordChangeSuccessfully => 'Password changed successfully.';

  @override
  String get passwordResetCodeSentPleaseCheckYourEmail =>
      'Password reset code sent. Please check your email.';

  @override
  String get update => 'Update';
}
