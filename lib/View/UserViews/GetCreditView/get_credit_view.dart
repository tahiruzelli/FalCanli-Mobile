import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Widgets/big_button.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:falcanli/View/UserViews/GetCreditView/Widgets/intro_slider.dart';
import 'package:flutter/material.dart';

class GetCreditView extends StatefulWidget {
  @override
  _VipMebershipState createState() => _VipMebershipState();
}

class _VipMebershipState extends State<GetCreditView> {
  List<bool> selectedList = [false, false, true, false];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GradiendContainer(),
            Column(
              children: [
                IntroSlider(),
                Row(
                  children: [
                    membershipType(0, size, ["500", "59,90₺"]),
                    membershipType(1, size, ["2500", "69,99₺"]),
                    membershipType(2, size, ["5000", "104,99₺"]),
                    membershipType(3, size, ["10000", "149,99 ₺"]),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BigButton("Kredi Al", () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget membershipType(int index, Size size, List texts) {
    bool isSelected = selectedList[index];
    return GestureDetector(
      onTap: () {
        for (var i = 0; i < 4; i++) {
          setState(() {
            index == i ? selectedList[i] = true : selectedList[i] = false;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Container(
          height: isSelected ? size.height * 0.17 : size.height * 0.15,
          width: isSelected ? size.width * 0.25 - 10 : size.width * 0.25 - 20,
          decoration: BoxDecoration(
            color: Colors.white,
            border: isSelected ? Border.all(color: mainColor, width: 2) : null,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 2, offset: Offset(0, 3)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  texts[0],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: mainColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  texts[1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
