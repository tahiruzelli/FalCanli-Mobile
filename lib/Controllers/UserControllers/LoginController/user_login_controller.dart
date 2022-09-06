import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Globals/global_vars.dart';
import 'package:falcanli/Repository/User/LoginRepository/login_repository.dart';
import 'package:falcanli/View/FortunerViews/LoginView/fortuner_login_view.dart';
import 'package:falcanli/View/FortunerViews/MainView/fortuner_main_view.dart';
import 'package:falcanli/View/UserViews/MainView/user_main_view.dart';
import 'package:falcanli/View/UserViews/RegisterView/user_register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

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
    } else if (passwordController.text.length < 7) {
      warningSnackBar("Şifreniz 7 karakterden küçük olamaz");
    } else {
      isLoginLoading.value = true;
      loginRepository
          .login(emailController.text, passwordController.text)
          .then((value) {
        isLoginLoading.value = false;
        if (isHttpOK(value['statusCode'])) {
          jwtToken = value['result'];
          Map<String, dynamic> payload = Jwt.parseJwt(jwtToken ?? "");
          GetStorage().write(userIdKey, payload['userid']);
          GetStorage().write(jwtTokenKey, jwtToken);
          GetStorage().write(isUserKey, payload['isFortuneTeller']);
          if (payload["isFortuneTeller"]) {
            Get.offAll(FortunerMainView());
          } else {
            Get.offAll(UserMainView());
          }
        } else {
          warningSnackBar(value['message']);
        }
      });
    }
  }
}
