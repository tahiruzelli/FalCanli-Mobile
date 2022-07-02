import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/View/FortunerViews/LoginView/fortuner_login_view.dart';
import 'package:falcanli/View/UserViews/MainView/user_main_view.dart';
import 'package:falcanli/View/UserViews/RegisterView/user_register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoginLoading = false.obs;

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

  void onLoginButtonPressed() {
    if (!GetUtils.isEmail(emailController.text)) {
      warningSnackBar("E mail formatınız hatalı");
    } else if (passwordController.text.length < 8) {
      warningSnackBar("Şifreniz 8 karakterden küçük olamaz");
    } else {
      isLoginLoading.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        isLoginLoading.value = false;
        Get.offAll(UserMainView());
      });
    }
  }
}
