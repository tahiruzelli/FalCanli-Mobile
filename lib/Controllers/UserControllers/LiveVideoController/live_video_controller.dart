import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Repository/User/FortunerRepository/fortuner_repository.dart';
import 'package:falcanli/View/UserViews/MainView/user_main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class LiveVideoController extends GetxController {
  FortunerRepository fortunerRepository = FortunerRepository();
  TextEditingController commentController = TextEditingController();

  RxBool isRateLoading = false.obs;

  Future rateCall(String conversationId, int point) async {
    isRateLoading.value = true;
    fortunerRepository
        .rateCall(
      conversationId: conversationId,
      point: point,
      comment: commentController.text,
    )
        .then((value) {
      isRateLoading.value = false;
      if (isHttpOK(value["statusCode"])) {
        Get.offAll(UserMainView());
        infoSnackBar("Görüşmeniz başarı ile değerlendirilmiştir");
      } else {
        warningSnackBar(value['message']);
      }
    });
  }
}
