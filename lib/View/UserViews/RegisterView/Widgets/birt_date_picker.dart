import 'package:falcanli/Controllers/UserControllers/RegisterController/user_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Globals/Constans/colors.dart';
import '../../../../Globals/Utils/date_time.dart';

class BirthDayPicker extends StatelessWidget {
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
              "Doğum Günü",
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
                  DateTime? picked = await showDatePicker(
                      helpText: "Başlangıç Tarihi Seçiniz",
                      locale: const Locale("tr", "TR"),
                      context: context,
                      firstDate: DateTime(1970),
                      initialDate: DateTime(1971),
                      lastDate: DateTime(2010));
                  if (picked != null) {
                    registerController.birthDate = picked;

                    registerController.birtDateString.value =
                        formatDateTime(registerController.birthDate!);
                  }
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
                        registerController.birthDate == null
                            ? "Tarih Seçiniz"
                            : registerController.birtDateString.value,
                        style: const TextStyle(
                          color: mainColor,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        registerController.birthDate == null
                            ? "Tarih Seçiniz"
                            : registerController.birtDateString.value,
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
