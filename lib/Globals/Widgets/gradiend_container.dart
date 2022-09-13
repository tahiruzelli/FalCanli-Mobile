import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:flutter/material.dart';

class GradiendContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            mainColor,
            mainColor.withGreen(10),
          ],
          // stops: [0.1, 0.4, 0.7, 0.9, 1],
        ),
      ),
    );
  }
}
