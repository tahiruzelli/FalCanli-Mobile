import 'package:falcanli/Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/Globals/Widgets/detail_line.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:falcanli/Globals/Widgets/loading_indicator.dart';
import 'package:falcanli/View/UserViews/FortunersView/comments_view.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FortunerDetailView extends StatelessWidget {
  late int index;
  late UserFortunerController fortunerController;
  FortunerDetailView(this.index, this.fortunerController);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Ayşa Fatma"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            fortunerController.onGoLiveWithFortunerButtonPressed(index % 3),
        label: const Text("Falcı ile görüş!"),
        backgroundColor: mainColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          GradiendContainer(),
          ListView(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                height: Get.height * 0.2,
                width: Get.width,
                child: Row(
                  children: [
                    SizedBox(
                      height: Get.height * 0.2,
                      width: Get.width * 0.8,
                      child: const CircleAvatar(
                        minRadius: 50,
                        maxRadius: 100,
                        backgroundImage: NetworkImage(
                          "https://play-lh.googleusercontent.com/mwLEUp9QssZBnOZPcfAeRULCU2550Ofa_WK5CY9Omo8LHlrY08_h1BnXzKyHp9_zhfzg",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.05),
                      child: SizedBox(
                        height: Get.height * 0.2,
                        width: Get.width * 0.15,
                        child: Image.asset(
                          "assets/images/${index % 3 == 0 ? "trafficRed" : index % 3 == 1 ? "trafficYellow" : "trafficGreen"}.png",
                          fit: BoxFit.cover,
                          height: Get.height * 0.2,
                          width: Get.width * 0.15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              DetailLine("İsim", "Ayşe Fatma"),
              DetailLine("Uzmanlık", "Tarot, kahve"),
              pointLine(),
              DetailLine("Yaş", "35"),
              DetailLine("Puan", "8.2/10"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet ",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Get.to(CommentsView(fortunerController));
                      fortunerController.getComments();
                    },
                    title: const Text("Yorumları gör"),
                    trailing: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
            ],
          ),
          // Center(
          //   child: RotationTransition(
          //     turns: const AlwaysStoppedAnimation(45 / 360),
          //     child: Text(
          //       "Müsait Değil",
          //       style: TextStyle(
          //         fontSize: 75,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.red.withAlpha(50),
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget pointLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.04),
                child: Text(
                  "Puan",
                  style: TextStyle(
                    fontSize: Get.height * 0.02,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: Get.width * 0.04,
                  ),
                  child: FFStars(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
