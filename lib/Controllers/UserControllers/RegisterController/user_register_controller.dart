import 'dart:io';

import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Utils/date_time.dart';
import 'package:falcanli/Globals/Utils/files.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Repository/User/RegisterRepository/register_repository.dart';
import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uri_to_file/uri_to_file.dart';

class UserRegisterController extends GetxController {
  RegisterRepository registerRepository = RegisterRepository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  DateTime? birthDate;
  TimeOfDay? birthTime;
  File? image;

  RxBool shouldReload = false.obs;
  RxBool birtTimeOpen = true.obs;
  RxBool readKVKK = false.obs;
  RxBool readKK = false.obs;
  RxBool registerLoading = false.obs;
  RxBool isImageSelected = false.obs;

  RxString birtDateString = "".obs;
  RxString sexStatus = "Kadın".obs;

  Future getImage() async {
    isImageSelected.value = false;
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.image = File(image.path);
      isImageSelected.value = true;
    }
  }

  void facebookRegister(
      {required String url,
      required String name,
      required String email}) async {
    try {
      if (!registerLoading.value) {
        if (!readKVKK.value) {
          warningSnackBar("KVKK'yı kabul etmelisiniz");
        }
        if (!readKK.value) {
          warningSnackBar("Kullanım koşullarını kabul etmelisiniz");
        } else if (passwordController.text.length < 8) {
          warningSnackBar("Şifreniz 8 karakterden az olamaz");
        } else if (birthDate == null) {
          warningSnackBar("Doğum gününü boş bırakamazsınız");
        } else if (!birtTimeOpen.value && birthTime == null) {
          warningSnackBar("Doğum zamanınız boş kalamaz");
        } else {
          registerLoading.value = true;
          File file = await urlToFile(url);
          registerRepository
              .register(
            name: name,
            lastName: "",
            password: passwordController.text,
            email: email,
            birthday: dateToTimeStamp(birthDate ?? DateTime.now()),
            gender: sexStatus.value.toLowerCase(),
            file: file,
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
    } on UnsupportedError catch (e) {
      print(e.message); // Unsupported error for uri not supported
      registerLoading.value = false;
    } on IOException catch (e) {
      print(e); // IOException for system error
      registerLoading.value = false;
    } catch (e) {
      print(e); // General exception
      registerLoading.value = false;
    }
  }

  void onRegisterButtonPressed() {
    if (!registerLoading.value) {
      if (!readKVKK.value) {
        warningSnackBar("KVKK'yı kabul etmelisiniz");
      }
      if (!readKK.value) {
        warningSnackBar("Kullanım koşullarını kabul etmelisiniz");
      }
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
      } else if (image == null) {
        warningSnackBar("Resim seçmeniz gerekmektedir");
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
          file: image!,
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
