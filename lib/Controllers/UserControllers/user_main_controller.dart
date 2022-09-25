import 'package:falcanli/Repository/User/FortunerRepository/fortuner_repository.dart';
import 'package:falcanli/Repository/User/ProfileRepository/user_profile_repository.dart';
import 'package:falcanli/View/UserViews/FortunersView/status_select_view.dart';
import 'package:falcanli/View/UserViews/GetCreditView/get_credit_view.dart';
import 'package:falcanli/View/UserViews/ProfileView/user_profile_view.dart';
import 'package:get/get.dart';

class UserMainController extends GetxController {
  RxInt currentPageIndex = 0.obs;

  List bodyPages = [
    StatusSelectView(),
    GetCreditView(),
    UserProfileView(),
  ];

  void changePage(int value) {
    currentPageIndex.value = value;
  }

  String getAppBarTitle() {
    if (currentPageIndex.value == 0) {
      return "Fal Canlı";
    } else if (currentPageIndex.value == 1) {
      return "Kredi Yükle";
    } else if (currentPageIndex.value == 2) {
      return "Profil";
    } else {
      return "";
    }
  }

  get getBodyPages {
    return bodyPages[currentPageIndex.value];
  }
}
