import 'package:email_validator/email_validator.dart';

class InputValidator {
  InputValidator._();

  static String? text(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? email(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please provide your email address!';
    }
    if (!EmailValidator.validate(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
