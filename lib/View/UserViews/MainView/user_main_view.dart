import 'package:falcanli/Controllers/UserControllers/UserProfileController/user_profile_controller.dart';
import 'package:falcanli/Controllers/UserControllers/user_main_controller.dart';
import 'package:falcanli/Globals/Constans/urls.dart';
import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/Globals/global_vars.dart';
import 'package:falcanli/Repository/User/ProfileRepository/user_profile_repository.dart';
import 'package:falcanli/View/GlobalViews/pdf_view.dart';
import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:falcanli/View/UserViews/ProfileView/Pages/complete_profile_view.dart';
import 'package:falcanli/View/UserViews/StaticPages/faq_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Globals/Constans/colors.dart';
import '../../../Globals/Constans/storage_keys.dart';

class UserMainView extends StatelessWidget {
  final _advancedDrawerController = AdvancedDrawerController();
  UserMainController userMainController = Get.put(UserMainController());
  UserProfileController userProfileController =
      Get.put(UserProfileController());
  Color getIconColor(int index) {
    return userMainController.currentPageIndex.value != index
        ? mainColor
        : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    userProfileController.getUserDatas();
    userProfileController.getUserCredit();
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
                child: Image.network(userImage ?? emptyUser),
              ),
              ListTile(
                onTap: () => Get.to(FaqView()),
                leading: const Icon(Icons.question_answer_outlined),
                title: const Text("S.S.S."),
              ),
              ListTile(
                onTap: () => Get.to(PdfView(
                  path: "assets/pdfs/kk.pdf",
                  title: "Kullanım Koşulları",
                )),
                leading: const Icon(Icons.rule),
                title: const Text("Kullanım Koşulları"),
              ),
              ListTile(
                onTap: () => Get.to(PdfView(
                  path: "assets/pdfs/kvkk.pdf",
                  title: "KVKK",
                )),
                leading: const Icon(Icons.rule),
                title: const Text("KVKK"),
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
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () =>
                            userProfileController.isRemainingCreditLoading.value
                                ? Container()
                                : Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/coinIcon.png",
                                        height: 20,
                                        width: 30,
                                      ),
                                      Text(userProfileController
                                          .remainingCredit.value
                                          .toString()),
                                    ],
                                  ),
                      ),
                      GestureDetector(
                        onTap: () {
                          userMainController.changePage(1);
                        },
                        child: const Text(
                          "Kredi Al",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          body: userMainController.getBodyPages,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) => userMainController.changePage(index),
            currentIndex: userMainController.currentPageIndex.value,
            fixedColor: mainColor,
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
