import 'package:flutter/services.dart';

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if the new value starts with a space
    if (newValue.text.startsWith(' ')) {
      // Return the old value to prevent the space from being added
      return oldValue;
    }
    return newValue;
  }
}

class UpperCaseAlphaNumericFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Hanya ambil huruf (A-Z, a-z) dan angka (0-9)
    String filteredText = newValue.text.replaceAll(
      RegExp(r'[^a-zA-Z0-9 ]'),
      '',
    );

    return newValue.copyWith(
      text: filteredText.toUpperCase(), // Ubah ke huruf kapital
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}
