import 'package:falcanli/View/UserViews/FortunersView/fortuner_detail_view.dart';
import 'package:get/get.dart';

import '../../../View/UserViews/VideoCallView/video_call_view.dart';

class FortunerController extends GetxController {
  RxInt filterIndex = 0.obs;

  RxBool fortunersLoading = false.obs;

  void onFortunerCardPressed(int index, FortunerController fortunerController) {
    Get.to(FortunerDetailView(index, fortunerController));
  }

  Future getFortunerList() async {
    fortunersLoading.value = true;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      fortunersLoading.value = false;
    });
  }

  Future onGoLiveWithFortunerButtonPressed(int index) async {
    if (index == 0) {
      Get.defaultDialog(
          title: "Uyarı",
          middleText:
              "Falcımız şu an müsait değil fakat üzülme. Başka falcılarımız sizi bekliyor!");
    } else if (index == 1) {
      Get.defaultDialog(
          title: "Uyarı",
          middleText:
              "Falcımız şu an başka biri ile görüşüyor ama üzülme. Başka falcılarımız sizi bekliyor!");
    } else if (index == 2) {
      Get.to(VideoCallView());
    }
  }
}
