import 'package:falcanli/Controllers/UserControllers/user_main_controller.dart';
import 'package:falcanli/Globals/Constans/urls.dart';
import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:falcanli/View/UserViews/ProfileView/Pages/complete_profile_view.dart';
import 'package:falcanli/View/UserViews/StaticPages/faq_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import '../../../Globals/Constans/colors.dart';
import '../../../Globals/Constans/storage_keys.dart';

class UserMainView extends StatelessWidget {
  final _advancedDrawerController = AdvancedDrawerController();
  UserMainController userMainController = Get.put(UserMainController());
  UserFortunerController fortunerController = Get.put(UserFortunerController());
  Color getIconColor(int index) {
    return userMainController.currentPageIndex.value != index
        ? mainColor
        : darkBlue;
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: mainColor,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            children: [
              Container(
                width: Get.height / 10,
                height: Get.height / 10,
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 15,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.network(emptyUser),
              ),
              ListTile(
                onTap: () => Get.to(FaqView()),
                leading: const Icon(Icons.question_answer_outlined),
                title: const Text("S.S.S."),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.rule),
                title: const Text("Kurallar"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.rule),
                title: const Text("bla bla"),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  GetStorage().remove(jwtTokenKey);
                  GetStorage().remove(userDataKey);
                  GetStorage().remove(isUserKey);
                  Get.offAll(UserLoginView());
                },
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: const Text('Çıkış Yap',
                    style: TextStyle(color: Colors.red)),
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
      child: Obx(
        () => Scaffold(
          appBar: customAppBar(
            advancedDrawerController: _advancedDrawerController,
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
      ),
    );
  }
}
