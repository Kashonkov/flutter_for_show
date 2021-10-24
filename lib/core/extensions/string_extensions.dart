import 'package:i_talent/core/helper/date_formats.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:jiffy/jiffy.dart';


extension StringExt on String? {
  bool equalsIgnoreCase(String string) {
    return this?.toLowerCase() == string.toLowerCase();
  }

  bool isNullOrEmpty() => this == null || this!.isEmpty;

  DateTime? parseDate({String pattern = DateFormats.DEFAULT_UTC}) {
    return Jiffy(this, pattern).dateTime;
  }

  String formatPhoneNumber() {
    return MaskTextInputFormatter(mask: "+7 (###) ###-##-##", filter: {"#": RegExp(r'[0-9]')})
        .formatEditUpdate(
        TextEditingValue(),
        TextEditingValue(
            text: this!.startsWith("8") ? "7${this!.substring(1)}" : this!,
            selection: TextSelection.collapsed(offset: 100)))
        .text;
  }

  String clearNotDigits(){
    return this!.replaceAll(RegExp(r'\D'), "");
  }
}
