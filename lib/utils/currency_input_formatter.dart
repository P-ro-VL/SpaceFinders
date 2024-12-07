import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the input is empty, return the new value.
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove any non-digit characters.
    final newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Format the string as a currency.
    final formattedText = _formatter.format(int.parse(newText));

    // Keep the cursor at the correct position.
    final selectionIndex =
        formattedText.length - (newValue.text.length - newValue.selection.end);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
