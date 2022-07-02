import 'package:falcanli/Controllers/UserControllers/RegisterController/user_register_controller.dart';
import 'package:falcanli/Globals/Widgets/big_button.dart';
import 'package:falcanli/Globals/Widgets/custom_textfield.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:falcanli/View/UserViews/RegisterView/Widgets/birt_date_picker.dart';
import 'package:falcanli/View/UserViews/RegisterView/Widgets/birth_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Globals/Styles/text_styles.dart';

class UserRegisterView extends StatelessWidget {
  UserRegisterController userRegisterController =
      Get.put(UserRegisterController());
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
                    "Üye Ol",
                    style: bigTitleStyle,
                  ),
                ),
                Column(
                  children: [
                    CustomTextField(
                        "Tam isim", userRegisterController.nameController),
                    const SizedBox(height: 20),
                    CustomTextField("E-mail Adresiniz",
                        userRegisterController.emailController),
                    const SizedBox(height: 20),
                    CustomTextField(
                      "Şifreniz",
                      userRegisterController.passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    BirthDayPicker(),
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: userRegisterController.birtTimeOpen.value,
                            onChanged: (bool? value) {
                              userRegisterController.birtTimeOpen.value =
                                  value ?? false;
                            },
                          ),
                        ),
                        const Text("Doğum saatimi bilmiyorum"),
                      ],
                    ),
                    Obx(
                      () => userRegisterController.birtTimeOpen.value
                          ? Container()
                          : BirthTimePicker(),
                    ),
                    const SizedBox(height: 30),
                    Obx(
                      () => BigButton(
                          userRegisterController.registerLoading.value
                              ? "Yükleniyor..."
                              : "Üye Ol", () {
                        userRegisterController.onRegisterButtonPressed();
                      }),
                    )
                  ],
                ),
                Container(),
                Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
