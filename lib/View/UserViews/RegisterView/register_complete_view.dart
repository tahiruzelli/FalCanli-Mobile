import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:flutter/material.dart';

class RegisterCompleteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [GradiendContainer()],
        ),
      ),
    );
  }
}
