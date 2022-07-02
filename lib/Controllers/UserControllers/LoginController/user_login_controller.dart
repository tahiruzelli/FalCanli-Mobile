import 'package:falcanli/View/FortunerViews/LoginView/fortuner_login_view.dart';
import 'package:falcanli/View/UserViews/RegisterView/user_register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onFortunerLoginButtonPressed() {
    emailController.clear();
    passwordController.clear();
    Get.off(FortunerLoginView());
  }

  void onRegisterButtonPressed() {
    emailController.clear();
    passwordController.clear();
    Get.to(UserRegisterView());
  }
}
