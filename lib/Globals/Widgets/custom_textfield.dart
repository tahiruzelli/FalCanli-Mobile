import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  late String prefixText;
  late TextEditingController controller;
  late bool obscureText;
  late TextInputType textInputType;
  late bool toLowerCase;
  late bool isWhite;

  CustomTextField(
    this.prefixText,
    this.controller, {
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.toLowerCase = false,
    this.isWhite = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isWhite ? Colors.white : iosGreyColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: textInputType,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        cursorColor: mainColor,
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
