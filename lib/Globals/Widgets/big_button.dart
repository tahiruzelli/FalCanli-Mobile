import 'package:flutter/material.dart';

import '../Constans/colors.dart';

class BigButton extends StatelessWidget {
  late String title;
  late Color color;
  late void Function() action;
  BigButton(this.title, this.action, {this.color = mainColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 15)),
        ),
        onPressed: action,
        child: Text(
          title,
          style: TextStyle(
            color: color,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
