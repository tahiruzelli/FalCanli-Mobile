import 'package:falcanli/Controllers/UserControllers/RegisterController/user_register_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Widgets/big_button.dart';
import 'package:falcanli/Globals/Widgets/custom_textfield.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:falcanli/View/GlobalViews/pdf_view.dart';
import 'package:falcanli/View/UserViews/ProfileView/Pages/Widgets/sex_picker.dart';
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
            child: ListView(
              children: [
                Image.asset(
                  "assets/images/logo_text.png",
                  height: Get.height / 5,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                    "Tam İsim", userRegisterController.nameController),
                const SizedBox(height: 20),
                CustomTextField(
                    "E-mail Adresiniz", userRegisterController.emailController),
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
                        fillColor: MaterialStateProperty.all(mainColor)
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
                SexPicker(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: () => userRegisterController.getImage(),
                      child: Container(
                          height: Get.height / 5,
                          decoration: BoxDecoration(
                            color: iosGreyColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Obx(
                            () => userRegisterController.isImageSelected.value
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      userRegisterController.image!,
                                      height: Get.height / 5,
                                    ),
                                  )
                                : const Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Fotoğraf seçiniz",
                                        style: TextStyle(
                                          color: mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                value: userRegisterController.readKK.value,
                                onChanged: (bool? value) {
                                  userRegisterController.readKK.value =
                                      value ?? false;
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () => Get.to(PdfView(
                                title: "Kullanım Koşulları",
                                path: "assets/pdfs/kk.pdf",
                              )),
                              child: const Text(
                                "Kullanım koşullarını okudum",
                                style: TextStyle(color: iosGreyColor),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                value: userRegisterController.readKVKK.value,
                                onChanged: (bool? value) {
                                  userRegisterController.readKVKK.value =
                                      value ?? false;
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () => Get.to(PdfView(
                                path: "assets/pdfs/kvkk.pdf",
                                title: "KVKK",
                              )),
                              child: const Text(
                                "KVKK'nu kabul ediyorum.",
                                style: TextStyle(color: iosGreyColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Obx(
                  () => BigButton(
                      userRegisterController.registerLoading.value
                          ? "Yükleniyor..."
                          : "Üye Ol", () {
                    userRegisterController.onRegisterButtonPressed();
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
