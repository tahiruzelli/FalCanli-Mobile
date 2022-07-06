import 'package:falcanli/Controllers/UserControllers/UserProfileController/user_profile_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/View/UserViews/ProfileView/Pages/Widgets/job_picker.dart';
import 'package:falcanli/View/UserViews/ProfileView/Pages/Widgets/marial_status_picker.dart';
import 'package:falcanli/View/UserViews/ProfileView/Pages/Widgets/relationship_picker.dart';
import 'package:falcanli/View/UserViews/ProfileView/Pages/Widgets/sex_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileView extends StatelessWidget {
  UserProfileController profileController = Get.put(UserProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Profili Tamamla"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.back(),
        label: const Text("Bilgileri Kaydet"),
        backgroundColor: mainColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          MarialStatusPicker(),
          SexPicker(),
          ReloationshipPicker(),
          JobPicker(profileController.jobList),
        ],
      ),
    );
  }
}
