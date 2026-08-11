import 'package:e_commerce_app/core/constants/app_keys.dart';

abstract class Validator {
  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(AppKeys.emailRegex);
    if (val == null || val.trim().isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(val)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    final RegExp passwordRegex = RegExp(AppKeys.passwordRegex);
    if (val == null || val.isEmpty) {
      return 'Password cannot be empty';
    } else if (!passwordRegex.hasMatch(val)) {
      return 'Enter a valid password';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'Password cannot be empty';
    } else if (val != password) {
      return 'Confirm password must match the password';
    } else {
      return null;
    }
  }

  static String? validateName(String? val) {
    if (val == null || val.isEmpty) {
      return 'Name cannot be empty';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }

    final phone = val.trim();
    final isValid = RegExp(r'^\+?\d+$').hasMatch(phone);
    if (!isValid || phone.length != 13) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  static String? validateCode(String? val) {
    if (val == null || val.isEmpty) {
      return 'Code cannot be empty';
    } else if (val.length < 6) {
      return 'Code should be at least 6 digits';
    } else {
      return null;
    }
  }

  static String? validateCardNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Card number cannot be empty';
    }
    final cleanVal = val.replaceAll(' ', '');
    if (cleanVal.length < 16) {
      return 'Card number must be at least 16 digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(cleanVal)) {
      return 'Card number must contain numbers only';
    }
    return null;
  }

  static String? validateCVV(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'CVV cannot be empty';
    }
    if (val.trim().length != 3) {
      return 'CVV must be exactly 3 digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(val.trim())) {
      return 'CVV must contain numbers only';
    }
    return null;
  }

  static String? validateExpiryDate(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Expiry date cannot be empty';
    }
    return null;
  }
}
