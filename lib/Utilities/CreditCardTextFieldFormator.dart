import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardTextFieldFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    print(text.length);
    for (int i = 0; i < text.length; i++) {
      // print(i);
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 6 == 0 && nonZeroIndex == text.length) {
          buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}