import 'package:falcanli/Controllers/FortunerControllers/LoginController/fortuner_login_controller.dart';
import 'package:falcanli/Controllers/UserControllers/LoginController/user_login_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Styles/text_styles.dart';
import 'package:falcanli/Globals/Widgets/custom_textfield.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FortunerLoginView extends StatelessWidget {
  FortunerLoginController fortunerLoginController =
      Get.put(FortunerLoginController());
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
                        "E-Mail", fortunerLoginController.emailController),
                    const SizedBox(height: 20),
                    CustomTextField(
                        "Şifre", fortunerLoginController.passwordController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => fortunerLoginController
                              .onUserLoginButtonPressed(),
                          child: const Text(
                            "Kullanıcı Girişi",
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
        onPressed: () {},
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: const Text(
          'Giriş Yap',
          style: TextStyle(
            color: mainColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
