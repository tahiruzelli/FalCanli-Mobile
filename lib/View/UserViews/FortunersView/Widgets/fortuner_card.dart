import 'package:falcanli/Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/Globals/Constans/urls.dart';
import 'package:falcanli/Models/fortuner.dart';
import 'package:falcanli/View/UserViews/FortunersView/Widgets/proffesion_line.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:flutter/material.dart';

class FortunerCard extends StatelessWidget {
  final Fortuner fortuner;
  final UserFortunerController fortunerController;
  FortunerCard({
    required this.fortuner,
    required this.fortunerController,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Card(
        child: ListTile(
          onTap: () => fortunerController.onFortunerCardPressed(
              fortunerController, fortuner),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(fortuner.photo ?? emptyUser),
          ),
          title: Text(fortuner.nickname ?? ""),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FFStars(
                normalStar: Image.asset("assets/icons/unselectedStar.png"),
                selectedStar: Image.asset("assets/icons/selectedStar.png"),
                step: 0.01,
                defaultStars: fortuner.averagePoint ?? 1,
                justShow: true,
                starHeight: 20,
                starWidth: 20,
                starMargin: 3,
              ),
            ],
          ),
          trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        fortunerController.fortuneType == FortuneType.coffee
                            ? fortuner.coffeeServiceFee.toString()
                            : fortunerController.fortuneType ==
                                    FortuneType.astrology
                                ? fortuner.astrologyServiceFee.toString()
                                : fortunerController.fortuneType ==
                                        FortuneType.natalChart
                                    ? fortuner.birthChartServiceFee.toString()
                                    : fortuner.tarotServiceFee.toString(),
                      ),
                      Image.asset(
                        "assets/icons/coinIcon.png",
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                Text(
                  fortuner.fortuneTellerStatus ?? "",
                  style: TextStyle(
                    color: fortuner.fortuneTellerStatus.toString() == "müsait"
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
