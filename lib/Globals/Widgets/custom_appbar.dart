import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:flutter/material.dart';

AppBar customAppBar({
  String title = ""
}){
  return AppBar(
    title: Text(title),
    centerTitle: true,
    backgroundColor: mainColor,
  );
}