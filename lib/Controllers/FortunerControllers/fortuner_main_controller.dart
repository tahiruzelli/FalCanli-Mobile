import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../View/FortunerViews/HomeView/fortuner_home_view.dart';
import '../../View/FortunerViews/ProfileView/fortuner_profile_view.dart';

class FortunerMainController extends GetxController {
  RxInt currentPageIndex = 0.obs;

  List bodyPages = [
    FortunerHomeView(),
    Container(),
    FortunerProfileView(),
  ];

  void changePage(int value) {
    currentPageIndex.value = value;
  }

  String getAppBarTitle() {
    if (currentPageIndex.value == 0) {
      return "Ana Sayfa";
    } else if (currentPageIndex.value == 1) {
      return "İstatistikler";
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
