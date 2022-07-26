import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Globals/global_vars.dart';
import 'package:falcanli/Repository/User/LoginRepository/login_repository.dart';
import 'package:falcanli/View/FortunerViews/LoginView/fortuner_login_view.dart';
import 'package:falcanli/View/UserViews/MainView/user_main_view.dart';
import 'package:falcanli/View/UserViews/RegisterView/user_register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserLoginController extends GetxController {
  LoginRepository loginRepository = LoginRepository();

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
      loginRepository
          .login(emailController.text, passwordController.text)
          .then((value) {
        isLoginLoading.value = false;
        if (isHttpOK(value['statusCode'])) {
          Get.offAll(UserMainView());
          jwtToken = value['result'];
          GetStorage().write(jwtTokenKey, jwtToken);
          GetStorage().write(isUserKey, true);
        } else {
          warningSnackBar(value['message']);
        }
      });
    }
  }
}
