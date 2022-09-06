import 'package:falcanli/Controllers/UserControllers/RegisterController/user_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Globals/Constans/colors.dart';

class BirthTimePicker extends StatelessWidget {
  UserRegisterController registerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Text(
              "Doğum Zamanı",
              style: TextStyle(
                fontSize: Get.height * 0.02,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.04),
            child: Obx(
              () => ElevatedButton(
                onPressed: () async {
                  registerController.birthTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  registerController.shouldReload.value = true;
                  registerController.shouldReload.value = false;
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(iosGreyColor),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 15)),
                ),
                child: registerController.shouldReload.value
                    ? Text(
                        (registerController.birthTime == null
                            ? "Saat Seçiniz"
                            : "${registerController.birthTime!.hour}:${registerController.birthTime!.minute}"),
                        style: const TextStyle(
                          color: mainColor,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        (registerController.birthTime == null
                            ? "Saat Seçiniz"
                            : "${registerController.birthTime!.hour}:${registerController.birthTime!.minute}"),
                        style: const TextStyle(
                          color: mainColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
