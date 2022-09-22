import 'package:falcanli/Controllers/UserControllers/LoginController/user_login_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Styles/text_styles.dart';
import 'package:falcanli/Globals/Widgets/custom_textfield.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginView extends StatelessWidget {
  UserLoginController userLoginController = Get.put(UserLoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradiendContainer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/logo_text.png",
                  height: Get.height / 5,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    CustomTextField(
                        "E-Mail", userLoginController.emailController),
                    const SizedBox(height: 20),
                    CustomTextField(
                      "Şifre",
                      userLoginController.passwordController,
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Şifremi Unuttum",
                          style: TextStyle(color: iosGreyColor),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () =>
                            userLoginController.onRegisterButtonPressed(),
                        child: const Text(
                          "Hesabın mı yok? Hemen üye ol",
                          style: TextStyle(
                            color: iosGreyColor,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        loginButton,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: facebookLoginButton,
                        ),
                      ],
                    )
                  ],
                ),
                Container(),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get loginButton {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 15)),
          ),
          onPressed: () => userLoginController.onLoginButtonPressed(),
          child: Obx(
            () => Text(
              userLoginController.isLoginLoading.value
                  ? "Yükleniyor..."
                  : 'Giriş Yap',
              style: const TextStyle(
                color: mainColor,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          )),
    );
  }

  Widget get facebookLoginButton {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 15)),
          ),
          onPressed: () => userLoginController.onLoginWithFacebook(),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.facebook,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  userLoginController.isLoginLoading.value
                      ? "Yükleniyor..."
                      : 'Facebook ile üye ol',
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
