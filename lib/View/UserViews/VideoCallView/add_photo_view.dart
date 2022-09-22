import 'package:falcanli/Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/View/UserViews/FortunersView/Widgets/add_photo_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class AddPhotoView extends StatelessWidget {
  UserFortunerController fortunerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Fotoğraf Ekle"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (fortunerController.images.length == 3) {
            // fortunerController.startVideoCall();
          } else {
            warningSnackBar("3 Adet fotoğraf seçiniz!");
          }
        },
        label: const Text("Görüşmeye Başla"),
        backgroundColor: mainColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Falcının kahve falını detaylı bir şekilde inceleyebilmesi için kahve fincanın 3 farklı yerinden detaylı fotoğrafı galerinden yüklemeni bekliyoruz.",
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          PhotoArea(),
        ],
      ),
    );
  }
}
