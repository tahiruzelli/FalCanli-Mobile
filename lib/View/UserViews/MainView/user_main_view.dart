import 'package:falcanli/Controllers/UserControllers/user_main_controller.dart';
import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/View/UserViews/ProfileView/Pages/complete_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/UserControllers/UserProfileController/user_profile_controller.dart';
import '../../../Globals/Constans/colors.dart';

class UserMainView extends StatelessWidget {
  UserProfileController profileController = Get.put(UserProfileController());
  UserMainController userMainController = Get.put(UserMainController());
  Color getIconColor(int index) {
    return userMainController.currentPageIndex.value != index
        ? mainColor
        : darkBlue;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppBar(
          title: userMainController.getAppBarTitle(),
          action: userMainController.currentPageIndex.value == 2
              ? IconButton(
                  onPressed: () {
                    Get.to(CompleteProfileView());
                  },
                  icon: const Icon(Icons.settings),
                )
              : null,
        ),
        body: userMainController.getBodyPages,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) => userMainController.changePage(index),
          currentIndex: userMainController.currentPageIndex.value,
          fixedColor: darkBlue,
          items: [
            BottomNavigationBarItem(
              backgroundColor: iosGreyColor,
              icon: Icon(
                Icons.home,
                color: getIconColor(0),
              ),
              label: "Falcılar",
            ),
            BottomNavigationBarItem(
              backgroundColor: iosGreyColor,
              icon: Icon(
                Icons.add,
                color: getIconColor(0),
              ),
              label: "Kredi Yükle",
            ),
            BottomNavigationBarItem(
              backgroundColor: iosGreyColor,
              icon: Icon(
                Icons.person,
                color: getIconColor(1),
              ),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}
