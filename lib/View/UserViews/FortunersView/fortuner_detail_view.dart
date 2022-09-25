import 'package:falcanli/Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/Globals/Constans/urls.dart';
import 'package:falcanli/Globals/Utils/strings.dart';
import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/Globals/Widgets/detail_line.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:falcanli/Globals/Widgets/loading_indicator.dart';
import 'package:falcanli/Models/fortuner.dart';
import 'package:falcanli/View/UserViews/FortunersView/Widgets/add_photo_area.dart';
import 'package:falcanli/View/UserViews/FortunersView/comments_view.dart';
import 'package:falcanli/View/UserViews/VideoCallView/add_photo_view.dart';
import 'package:falcanli/View/UserViews/VideoCallView/video_call_view.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FortunerDetailView extends StatelessWidget {
  late UserFortunerController fortunerController;
  FortunerDetailView(this.fortunerController);
  @override
  Widget build(BuildContext context) {
    int avaibleStatus = fortunerController.currentFortuner!.fortuneTellerStatus
                .toString() ==
            "müsait"
        ? 0
        : fortunerController.currentFortuner!.fortuneTellerStatus.toString() ==
                "görüşmede"
            ? 1
            : 2;
    return Scaffold(
      appBar: customAppBar(
          title: fortunerController.currentFortuner?.nickname ?? "Falcı"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => fortunerController.fortuneType == FortuneType.coffee
            ? Get.to(AddPhotoView())
            : fortunerController.onGoLiveWithFortunerButtonPressed(),
        label: Obx(
          () => fortunerController.isfortunerResponseWaiting.value
              ? Center(
                  child: LoadingIndicator(),
                )
              : const Text("Falcı ile görüş!"),
        ),
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
                height: Get.height * 0.2 + 50,
                width: Get.width,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: Get.height * 0.2,
                          width: Get.width * 0.8,
                          child: CircleAvatar(
                            minRadius: 50,
                            maxRadius: 100,
                            backgroundImage: NetworkImage(
                              fortunerController.currentFortuner?.photo ??
                                  emptyUser,
                            ),
                          ),
                        ),
                        Text(
                          fortunerController.currentFortuner?.status ?? "",
                          style: const TextStyle(
                            color: iosGreyColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.05),
                      child: SizedBox(
                        height: Get.height * 0.2,
                        width: Get.width * 0.15,
                        child: Image.asset(
                          "assets/images/${avaibleStatus == 0 ? "trafficGreen" : avaibleStatus == 1 ? "trafficYellow" : "trafficRed"}.png",
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
              DetailLine("İsim",
                  fortunerController.currentFortuner?.nickname ?? "Falcı"),
              DetailLine(
                "Uzmanlık: ",
                proffesionToString(fortunerController.currentFortuner!),
              ),
              pointLine(),
              DetailLine(
                  "Yaş", fortunerController.currentFortuner!.age.toString()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      fortunerController.currentFortuner?.about ?? "",
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
                    defaultStars:
                        fortunerController.currentFortuner!.averagePoint ?? 0.0,
                    justShow: true,
                    starHeight: 20,
                    starWidth: 20,
                    starMargin: 3,
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

String proffesionToString(Fortuner fortuner) {
  String proffesionString = "";
  if (fortuner.hasCoffee ?? false) {
    proffesionString += "Kahve, ";
  }
  if (fortuner.hasTarot ?? false) {
    proffesionString += "Tarot, ";
  }
  if (fortuner.hasBirthChart ?? false) {
    proffesionString += "Doğum Haritası, ";
  }
  if (fortuner.hasAstrology ?? false) {
    proffesionString += "Astroloji, ";
  }
  return dropLastCharacter(dropLastCharacter(proffesionString));
}
