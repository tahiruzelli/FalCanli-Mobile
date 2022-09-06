import 'package:falcanli/Globals/Constans/urls.dart';
import 'package:falcanli/Globals/Utils/date_time.dart';
import 'package:falcanli/Globals/Widgets/detail_line.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:falcanli/Globals/Widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/UserControllers/UserProfileController/user_profile_controller.dart';
import '../../../Globals/Constans/colors.dart';

class UserProfileView extends StatelessWidget {
  UserProfileController profileController = Get.put(UserProfileController());
  @override
  Widget build(BuildContext context) {
    profileController.getUserCredit();
    return Scaffold(
      body: Stack(
        children: [
          GradiendContainer(),
          Obx(
            () => profileController.isProfileDatasLoading.value
                ? Center(
                    child: LoadingIndicator(),
                  )
                : ListView(
                    children: [
                      const SizedBox(height: 30),
                      const CircleAvatar(
                        minRadius: 50,
                        maxRadius: 100,
                        backgroundImage: NetworkImage(emptyUser),
                      ),
                      const SizedBox(height: 30),
                      DetailLine("Adi", profileController.user?.name ?? ""),
                      DetailLine(
                          "Dogum Tarihi",
                          formatDateTime(DateTime.parse(
                              profileController.user?.birthday ?? ""))),
                      DetailLine("Burç", profileController.user?.zodiac ?? ""),
                      profileController.isRemainingCreditLoading.value
                          ? LoadingIndicator()
                          : DetailLine(
                              "Kredi Miktarı",
                              profileController.remainingCredit.value
                                  .toString()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                                profileController.onLogoutButtonPressed(),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 15)),
                            ),
                            child: const Text(
                              "Çıkış Yap",
                              style: TextStyle(
                                color: colorDanger,
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
