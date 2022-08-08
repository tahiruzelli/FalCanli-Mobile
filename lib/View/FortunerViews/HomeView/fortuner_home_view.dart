import 'package:falcanli/Controllers/FortunerControllers/FortunerLiveController/fortuner_live_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FortunerHomeView extends StatelessWidget {
  FortunerLiveController fortunerLiveController =
      Get.put(FortunerLiveController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              !fortunerLiveController.isFortunerOnline.value
                  ? "Görüşmeye Müsait Değil"
                  : "Görüşmeye Müsait",
              style: TextStyle(
                color: !fortunerLiveController.isFortunerOnline.value
                    ? Colors.red
                    : Colors.green,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: InkWell(
                radius: 300,
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  fortunerLiveController.changeAvailable();
                },
                child: Obx(
                  () => Icon(
                    Icons.power_settings_new,
                    size: 300,
                    color: !fortunerLiveController.isFortunerOnline.value
                        ? Colors.red
                        : Colors.green,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
