import 'package:flutter/material.dart';
import '../Constans/colors.dart';

class DetailLine extends StatelessWidget {
  late String title;
  late String content;
  DetailLine(this.title, this.content);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.04),
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: mainColor,
                    ),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
