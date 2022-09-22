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

class FacebookLoginView extends StatelessWidget {
  final String emailAdress;
  final String imageUrl;
  final String name;
  FacebookLoginView(
      {Key? key,
      required this.name,
      required this.emailAdress,
      required this.imageUrl})
      : super(key: key);
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
                          fillColor: MaterialStateProperty.all(mainColor)),
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
                ),
                Obx(
                  () => BigButton(
                      userRegisterController.registerLoading.value
                          ? "Yükleniyor..."
                          : "Üye Ol", () async {
                    userRegisterController.facebookRegister(
                      url: imageUrl,
                      name: name,
                      email: emailAdress,
                    );
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
