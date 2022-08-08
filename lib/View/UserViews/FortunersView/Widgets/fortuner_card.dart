import 'package:falcanli/Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/Models/fortuner.dart';
import 'package:falcanli/View/UserViews/FortunersView/Widgets/proffesion_line.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FortunerCard extends StatelessWidget {
  late Fortuner fortuner;
  FortunerCard({
    required this.fortuner,
  });
  UserFortunerController fortunerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Card(
        child: ListTile(
          onTap: () => fortunerController.onFortunerCardPressed(
              fortunerController, fortuner),
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.turuncufalcafe.com/fal-fotograflar/2019/03/falcihelen.jpg"),
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
                defaultStars: 4.3,
                justShow: true,
                // starCount: 5,
                starHeight: 20,
                starWidth: 20,
                starMargin: 3,
                // justShow: true,
                // followChange: true,
              ),
              // const SizedBox(height: 5),
              // ProffessionLine(
              //   tarot: tarot,
              //   kahve: kahve,
              //   dogumHaritasi: dogumHaritasi,
              //   astroloji: astroloji,
              // ),
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
