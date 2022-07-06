import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Controllers/UserControllers/UserProfileController/user_profile_controller.dart';
import '../../../../../Globals/Constans/colors.dart';

class ReloationshipPicker extends StatelessWidget {
  UserProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Card(
        child: ListTile(
          leading: Text(
            "İlişki Durumu: ",
            style: TextStyle(
              fontSize: Get.height * 0.02,
              color: Colors.black,
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Obx(
              () => DropdownButton<String>(
                value: profileController.relationshipStatus.value,
                elevation: 16,
                style: const TextStyle(color: mainColor),
                underline: Container(
                  height: 2,
                  color: mainColor,
                ),
                onChanged: (String? newValue) {
                  profileController.relationshipStatus.value = newValue!;
                },
                items: [
                  "Evli",
                  "Düzenli ilişki",
                  "Kısa süreli ilişki",
                  "İlişkisi yok",
                ].map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value.toString(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
