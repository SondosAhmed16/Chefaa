import 'package:email_validator/email_validator.dart';

class Validators {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Name cannot be empty';

    final RegExp nameRegExp = RegExp(r"^[\p{L}\s\-]+$", unicode: true);
    if (!nameRegExp.hasMatch(value)) {
      return 'Enter a valid name (letters, spaces, and hyphens only)';
    }
    if (value.length < 2) return 'Name must be at least 2 characters long';
    if (value.length > 50) return 'Name cannot exceed 50 characters';
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

    if (!usernameRegex.hasMatch(value)) {
      return 'Use only letters, numbers, and underscores (3-20 chars)';
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email cannot be empty.';
    if (!EmailValidator.validate(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone cannot be empty.';
    }

    final RegExp phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegExp.hasMatch(phone)) {
      return 'Enter a valid phone number (10-15 digits only)';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter password';

    final regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^a-zA-Z0-9]).{8,}$',
    );
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 chars\n and contain upper, lower,\n number & special char';
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  static String? validateLicense(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'License number is required';
    }

    final cleaned = value.replaceAll('-', '').toUpperCase();

    final regex = RegExp(r'^[A-Z]{3}\d{6}$');

    if (!regex.hasMatch(cleaned)) {
      return 'Enter 3 letters followed by 6 numbers';
    }

    return null;
  }

  static String? businessNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name cannot be empty';

    final RegExp businessNameRegExp = RegExp(
      r"^[\p{L}\p{N}\s\-\/&'.]+$",
      unicode: true,
    );
    if (!businessNameRegExp.hasMatch(value)) {
      return 'Enter a valid name (letters, numbers, spaces, and - / & . only)';
    }
    if (value.length < 2) return 'Name must be at least 2 characters long';
    if (value.length > 100) return 'Name cannot exceed 100 characters';
    return null;
  }

  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or phone cannot be empty.';
    }
    if (EmailValidator.validate(value)) {
      return null;
    }
    if (validatePhone(value) == null) {
      return null;
    }

    return 'Enter a valid email or phone number';
  }
}
