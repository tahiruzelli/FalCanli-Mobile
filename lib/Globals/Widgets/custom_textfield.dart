import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  late String prefixText;
  late TextEditingController controller;
  late bool obscureText;
  late TextInputType textInputType;
  late bool toLowerCase;

  CustomTextField(
    this.prefixText,
    this.controller, {
    this.obscureText = false,
    this.textInputType = TextInputType.none,
    this.toLowerCase = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: textInputType,
        style: const TextStyle(
          color: mainColor,
          fontSize: 12,
        ),
        maxLength: 30,
        cursorColor: mainColor,
        onChanged: (text) {
          if (toLowerCase) {
            controller.text = text.toLowerCase();
            controller.text = controller.text.trim();
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10),
          border: InputBorder.none,
          labelText: prefixText,
          counterText: '',
          labelStyle: const TextStyle(
            color: colorTextGrey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
