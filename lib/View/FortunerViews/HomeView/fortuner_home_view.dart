import 'package:falcanli/Controllers/FortunerControllers/FortunerLiveController/fortuner_live_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FortunerHomeView extends StatelessWidget {
  FortunerLiveController fortunerLiveController =
      Get.put(FortunerLiveController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradiendContainer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: iosGreyColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
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
                  ),
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
        ],
      ),
    );
  }
}
