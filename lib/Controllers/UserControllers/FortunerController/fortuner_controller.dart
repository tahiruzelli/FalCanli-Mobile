import 'package:falcanli/View/UserViews/FortunersView/fortuner_detail_view.dart';
import 'package:get/get.dart';

class FortunerController extends GetxController {
  void onFortunerCardPressed() {
    Get.to(FortunerDetailView());
  }
}
