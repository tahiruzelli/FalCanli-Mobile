import 'package:falcanli/Controllers/UserControllers/RegisterController/user_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Globals/Constans/colors.dart';

class SexPicker extends StatelessWidget {
  UserRegisterController registerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Cinsiyet: ",
                style: TextStyle(
                  fontSize: 12,
                  color: colorTextGrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Obx(
                () => DropdownButton<String>(
                  value: registerController.sexStatus.value,
                  elevation: 16,
                  style: const TextStyle(color: mainColor),
                  underline: Container(
                    height: 2,
                    color: mainColor,
                  ),
                  onChanged: (String? newValue) {
                    registerController.sexStatus.value = newValue!;
                  },
                  items: [
                    "Kadın",
                    "Erkek",
                    "Diğer",
                    "Belirtmek istemiyorum",
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
          ],
        ),
      ),
    );
  }
}
