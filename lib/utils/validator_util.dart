import 'package:flutter/services.dart';

class ValidatorUtil {
  static bool isPhoneValidEthiopian(String text) {
    bool isPhoneValidEthiopian = true;

    if (text.length == 13) {
      if (!text.startsWith("+251")) {
        isPhoneValidEthiopian = false;
      }
    }

    if (text.length == 12) {
      if (!text.startsWith("251")) {
        isPhoneValidEthiopian = false;
      }
    }

    if (text.length == 10) {
      if (!text.startsWith("0")) {
        isPhoneValidEthiopian = false;
      }
    }

    if (text.length == 9) {
      if (!text.startsWith("9")) {
        isPhoneValidEthiopian = false;
      }
    }

    if (text.length < 9 || text.length == 11 || text.length > 13) {
      isPhoneValidEthiopian = false;
    }
    return isPhoneValidEthiopian;
  }

  static String formatPhoneNumber(String text) {
    ///VALIDATE PHONE NUMBER FIRST
    if (!isPhoneValidEthiopian(text)) {
      throw 'PhoneNumberValidationError';
    }

    String formattedPhoneNumber = "";

    if (text.length == 13) {
      formattedPhoneNumber = text;
    }

    if (text.length == 12) {
      formattedPhoneNumber = '+$text';
    }

    if (text.length == 10) {
      formattedPhoneNumber = '+251${text.substring(1)}';
    }

    if (text.length == 9) {
      formattedPhoneNumber = '+251$text';
    }

    return formattedPhoneNumber;
  }
}

class AmharicInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value contains any non-Amharic characters
    if (newValue.text.contains(RegExp(r'[^ሀ-፿]'))) {
      // Non-Amharic characters found, return the old value to preserve it
      return oldValue;
    }

    // No non-Amharic characters found, accept the new value
    return newValue;
  }
}

class NoNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value contains any numeric characters, spaces, or special characters
    if (newValue.text.contains(RegExp(r'[0-9\s\W]'))) {
      // Numeric characters, spaces, or special characters found, return the old value to preserve it
      return oldValue;
    }

    // No numeric characters, spaces, or special characters found, accept the new value
    String newText = newValue.text;
    if (newText.length > 0) {
      newText = newText[0].toUpperCase() + newText.substring(1);
    }
    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    // Check if the new text is empty
    if (newText.isEmpty) {
      return newValue;
    }

    // Check if the new text matches the 'MM/DD/YYYY' format
    final regExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!regExp.hasMatch(newText)) {
      // If the new text doesn't match the format, return the old value
      return oldValue;
    }

    // If the new text matches the format, accept the new value
    return newValue;
  }
}

class HeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Check if the new value is a valid number
    final double? height = double.tryParse(newValue.text);
    if (height == null) {
      // If the new value is not a valid number, return the old value
      return oldValue;
    }

    // If the new value is a valid number, accept the new value
    return newValue;
  }
}
