import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Repository/User/ProfileRepository/user_profile_repository.dart';
import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Models/job.dart';
import '../../../Models/user.dart';

class UserProfileController extends GetxController {
  UserProfileRepository profileRepository = UserProfileRepository();

  TextEditingController jobController = TextEditingController();

  RxString marriageStatus = "Evli".obs;
  RxString sexStatus = "Kadın".obs;
  RxString relationshipStatus = "Evli".obs;

  RxInt selectedJobId = 0.obs;
  RxInt remainingCredit = 0.obs;

  RxBool isProfileDatasLoading = false.obs;
  RxBool isRemainingCreditLoading = false.obs;

  Job? selectedJob;
  User? user;

  List<Job> jobList = [
    Job(id: 1, name: "muhendis"),
    Job(id: 2, name: "issiz"),
    Job(id: 3, name: "bahcivan"),
    Job(id: 4, name: "esnaf"),
    Job(id: 5, name: "aşçı"),
  ];

  Future getUserDatas() async {
    String? userId = GetStorage().read(userIdKey);
    if (userId == null) {
      onLogoutButtonPressed();
      errorSnackBar("Bir hata oluştu, otomatik çıkış yapılıyor.");
    } else {
      isProfileDatasLoading.value = true;
      profileRepository.getProfileDatas(userId).then((value) {
        if (isHttpOK(value['statusCode'])) {
          user = User.fromJson(value['result']);
          isProfileDatasLoading.value = false;
        } else {
          warningSnackBar(value['message']);
          isProfileDatasLoading.value = false;
        }
      });
    }
  }

  Future getUserCredit() async {
    String? userId = GetStorage().read(userIdKey);
    if (userId == null) {
      onLogoutButtonPressed();
      errorSnackBar("Bir hata oluştu, otomatik çıkış yapılıyor.");
    } else {
      isRemainingCreditLoading.value = true;
      profileRepository.getUserCredit(userId).then((value) {
        if (isHttpOK(value['statusCode'])) {
          remainingCredit.value = value['result']['remainingCredit'];
        } else {
          warningSnackBar(value['message']);
        }
        isRemainingCreditLoading.value = false;
      });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    jobList.insert(0, Job(id: 0, name: "Diğer"));
  }

  void onLogoutButtonPressed() {
    GetStorage().remove(jwtTokenKey);
    GetStorage().remove(userDataKey);
    GetStorage().remove(userIdKey);
    GetStorage().remove(isUserKey);
    Get.offAll(UserLoginView());
  }
}
