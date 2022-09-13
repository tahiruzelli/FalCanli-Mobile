import 'package:falcanli/Controllers/UserControllers/user_main_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:falcanli/Globals/Widgets/loading_indicator.dart';
import 'package:falcanli/View/UserViews/FortunersView/fortuner_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import '../../../Controllers/UserControllers/UserProfileController/user_profile_controller.dart';

class StatusSelectView extends StatelessWidget {
  UserFortunerController fortunerController = Get.put(UserFortunerController());
  UserProfileController profileController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    profileController.getUserCredit();
    return Scaffold(
      body: Stack(
        children: [
          GradiendContainer(),
          ListView(
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Merhaba Tahir, Fal Canlı'ya hoşgeldin! Burada kahve, tarot, astroloji ya da doğum haritası fallarına baktırarak geleceğin hakkında yorumlar alıp tahminler yürütebilirsin! Hemen bir tık uzağında! Üstelik bunu falcı ile görüntülü bir şekilde konuşurken yapabilirsin. Haydı durma kredi yükleyip hemen falcılarımızla görüşmeye başla!",
                  style: TextStyle(
                    color: iosGreyColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      imageCard("assets/icons/kahveIcon.jpeg", "Kahve", () {}),
                      imageCard("assets/icons/tarotIcon.png", "Tarot", () {}),
                    ],
                  ),
                  Row(
                    children: [
                      imageCard("assets/icons/astrolojiIcon.jpeg", "Astoroloji",
                          () {}),
                      imageCard("assets/icons/dogumHaritasiIcon.jpeg",
                          "Doğum Haritası", () {}),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Güncel Kredin: ",
                    style: TextStyle(
                      color: iosGreyColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () => profileController.isRemainingCreditLoading.value
                        ? Center(
                            child: LoadingIndicator(),
                          )
                        : Text(
                            profileController.remainingCredit.value.toString(),
                            style: const TextStyle(
                              color: iosGreyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                  ),
                  TextButton(
                    onPressed: () {
                      UserMainController userMainController = Get.find();
                      userMainController.changePage(1);
                    },
                    child: const Text(
                      "Kredi Al!",
                      style: TextStyle(
                        color: colorSuccess,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget imageCard(String path, String title, Function onPressed) {
    return GestureDetector(
      onTap: () {
        onPressed();
        Get.to(FortunerListView());
        if (title == "Kahve") {
          fortunerController.fortuneType = FortuneType.coffee;
        }
        if (title == "Tarot") {
          fortunerController.fortuneType = FortuneType.tarot;
        }
        if (title == "Astroloji") {
          fortunerController.fortuneType = FortuneType.astrology;
        }
        if (title == "Doğum Haritası") {
          fortunerController.fortuneType = FortuneType.natalChart;
        }
      },
      child: SizedBox(
        width: Get.width / 2,
        height: Get.height / 4 + 45,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: iosGreyColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: iosGreyColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  height: Get.height / 4,
                  width: Get.width / 2 - 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
