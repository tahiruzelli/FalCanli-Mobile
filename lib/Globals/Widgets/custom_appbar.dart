import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:flutter/material.dart';

AppBar customAppBar({
  String title = "",
  Widget? action,
}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    backgroundColor: mainColor,
    actions: [
      action ?? Container(),
    ],
  );
}
