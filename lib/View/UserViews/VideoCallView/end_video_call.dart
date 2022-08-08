import 'package:falcanli/Controllers/UserControllers/LiveVideoController/live_video_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Widgets/big_button.dart';
import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/Globals/Widgets/custom_textfield.dart';
import 'package:falcanli/View/UserViews/MainView/user_main_view.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EndVideoCall extends StatelessWidget {
  LiveVideoController liveVideoController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Görüşmeni Değerlendir"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.offAll(UserMainView()),
        label: const Text("Değerlendirmeden geç"),
        backgroundColor: mainColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Falcınız ile olan görüşmeniz bitmiştir. Umarım güzel yorumlar almışsındır! Falcıyla olan görüşmeni değerlendirerek gelişmemize katkı sağlayabilirsin!",
                    style: TextStyle(
                      fontSize: 16,
                      color: mainColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BigButton("Görüşmeyi Değerlendir", () {
              rateCallPopUp(MediaQuery.of(context).size);
            }),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/logo_text.png",
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future rateCallPopUp(Size size) {
    return Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width / 10,
          vertical: size.height / 3.5,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FFStars(
                normalStar: Image.asset("assets/icons/unselectedStar.png"),
                selectedStar: Image.asset("assets/icons/selectedStar.png"),
                step: 0.01,
                defaultStars: 2.5,
                starHeight: 40,
                starWidth: 40,
                starMargin: 3,
                // followChange: true,
                starsChanged: (realStars, selectedStars) {
                  // use real starts
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: CustomTextField(
                    "Yorumunuz",
                    liveVideoController.commentController,
                    isWhite: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BigButton("Tamamla", () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
