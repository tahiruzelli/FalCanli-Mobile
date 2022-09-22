import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Globals/global_vars.dart';
import 'package:falcanli/Repository/User/LoginRepository/login_repository.dart';
import 'package:falcanli/View/FortunerViews/LoginView/fortuner_login_view.dart';
import 'package:falcanli/View/FortunerViews/MainView/fortuner_main_view.dart';
import 'package:falcanli/View/UserViews/LoginView/facebook_login_view.dart';
import 'package:falcanli/View/UserViews/MainView/user_main_view.dart';
import 'package:falcanli/View/UserViews/RegisterView/user_register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class UserLoginController extends GetxController {
  LoginRepository loginRepository = LoginRepository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoginLoading = false.obs;
  RxBool isFacebookLoginLoading = false.obs;

  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

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

  _checkIfisLoggedIn() async {
    isFacebookLoginLoading.value = true;
    final accessToken = await FacebookAuth.instance.accessToken;

    // setState(() {
      _checking = false;
    // });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      // setState(() {
        _userData = userData;
      // });
    } else {
      facebookLogin();
    }
  }

  facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      isFacebookLoginLoading.value = false;
      Get.to(FacebookLoginView(
        name: _userData!['name'],
        imageUrl: _userData!["picture"]['data']['url'],
        emailAdress: _userData!['email'],
      ));
      //email picture-data-url name
      //pw birthday gender
    } else {
      print(result.status);
      print(result.message);
    }
    // setState(() {
    _checking = false;
    // });
  }

  _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    // setState(() {});
  }

  void onLoginWithFacebook() {
    _checkIfisLoggedIn();
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
