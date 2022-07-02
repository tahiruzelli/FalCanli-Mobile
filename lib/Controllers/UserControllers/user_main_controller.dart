import 'package:falcanli/View/UserViews/FortunersView/fortuner_list_view.dart';
import 'package:falcanli/View/UserViews/GetCreditView/get_credit_view.dart';
import 'package:falcanli/View/UserViews/ProfileView/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMainController extends GetxController {
  RxInt currentPageIndex = 0.obs;

  List bodyPages = [
    FortunerListView(),
    GetCreditView(),
    UserProfileView(),
  ];

  void changePage(int value) {
    currentPageIndex.value = value;
  }

  String getAppBarTitle() {
    if (currentPageIndex.value == 0) {
      return "Falcılar";
    } else if (currentPageIndex.value == 1) {
      return "Kredi Yükle";
    } else if (currentPageIndex.value == 2) {
      return "Profil";
    } else {
      return "";
    }
  }
}
