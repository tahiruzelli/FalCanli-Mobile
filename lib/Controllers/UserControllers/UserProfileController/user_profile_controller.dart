import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/job.dart';

class UserProfileController extends GetxController {
  TextEditingController jobController = TextEditingController();

  RxString marriageStatus = "Evli".obs;
  RxString sexStatus = "Kadın".obs;
  RxString relationshipStatus = "Evli".obs;

  RxInt selectedJobId = 0.obs;

  Job? selectedJob;

  List<Job> jobList = [
    Job(id: 1, name: "muhendis"),
    Job(id: 2, name: "issiz"),
    Job(id: 3, name: "bahcivan"),
    Job(id: 4, name: "esnaf"),
    Job(id: 5, name: "aşçı"),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    jobList.insert(0, Job(id: 0, name: "Diğer"));
  }

  void onLogoutButtonPressed() {
    Get.offAll(UserLoginView());
  }
}
