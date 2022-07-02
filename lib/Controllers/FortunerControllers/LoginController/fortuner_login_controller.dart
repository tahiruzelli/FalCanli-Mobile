import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FortunerLoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onUserLoginButtonPressed() {
    emailController.clear();
    passwordController.clear();
    Get.off(UserLoginView());
  }

}
