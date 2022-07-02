import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  DateTime? birthDate;
  TimeOfDay? birthTime;

  RxBool shouldReload = false.obs;
  RxBool birtTimeOpen = true.obs;
  RxBool registerLoading = false.obs;

  RxString birtDateString = "".obs;

  void onRegisterButtonPressed() {
    if (!registerLoading.value) {
      if (!GetUtils.isEmail(emailController.text)) {
        warningSnackBar("Email Formatınız hatalı");
      } else if (passwordController.text.length < 8) {
        warningSnackBar("Şifreniz 8 karakterden az olamaz");
      } else if (nameController.text.split(" ").length < 2) {
        warningSnackBar("İsim ve soyisim giriniz");
      } else if (birthDate == null) {
        warningSnackBar("Doğum gününü boş bırakamazsınız");
      } else if (!birtTimeOpen.value && birthTime == null) {
        warningSnackBar("Doğum zamanınız boş kalamaz");
      } else {
        //TODO register
        registerLoading.value = true;
        Future.delayed(const Duration(seconds: 2), () {
          registerLoading.value = false;
          Get.offAll(UserLoginView());
        });
        print("register");
      }
    }
  }
}
