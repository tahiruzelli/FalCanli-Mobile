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
                const Center(
                  child: Text(
                    "Fal Canli",
                    style: bigTitleStyle,
                  ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => userLoginController
                              .onFortunerLoginButtonPressed(),
                          child: const Text(
                            "Falcı Girişi",
                            style: TextStyle(color: mainColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Şifremi Unuttum",
                            style: TextStyle(color: mainColor),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () =>
                            userLoginController.onRegisterButtonPressed(),
                        child: const Text(
                          "Hesabın mı yok? Hemen üye ol",
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ),
                    ),
                    loginButton,
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
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () => userLoginController.onLoginButtonPressed(),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
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
}
