import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Utils/date_time.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Repository/User/RegisterRepository/register_repository.dart';
import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRegisterController extends GetxController {
  RegisterRepository registerRepository = RegisterRepository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  DateTime? birthDate;
  TimeOfDay? birthTime;

  RxBool shouldReload = false.obs;
  RxBool birtTimeOpen = true.obs;
  RxBool registerLoading = false.obs;

  RxString birtDateString = "".obs;
  RxString sexStatus = "Kadın".obs;

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
        registerLoading.value = true;
        registerRepository
            .register(
          name: nameController.text,
          lastName: "",
          password: passwordController.text,
          email: emailController.text,
          birthday: dateToTimeStamp(birthDate ?? DateTime.now()),
          gender: sexStatus.value.toLowerCase(),
        )
            .then((value) {
          registerLoading.value = false;
          if (isHttpOK(value['statusCode'])) {
            Get.offAll(UserLoginView());
          } else {
            warningSnackBar(value['message']);
          }
        });
      }
    }
  }
}
