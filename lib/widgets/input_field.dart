// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/utils/color.dart';

class InputField extends StatelessWidget {
  InputField({
    required this.textController,
    required this.icon,
    required this.onChanged,
    this.inputType = TextInputType.name,
    Key? key,
  }) : super(key: key);
  IconData icon;
  Function(String?) onChanged;
  TextInputType inputType;
  TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(100)),
      child: TextFormField(
        controller: textController,
        onChanged: onChanged,
        cursorColor: blue.withOpacity(0.6),
        keyboardType: inputType,
        style: GoogleFonts.mulish(),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: blue.withOpacity(0.6)),
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: blue.withOpacity(0.6)),
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: red),
                borderRadius: const BorderRadius.all(Radius.circular(100)))),
      ),
    );
  }
}
