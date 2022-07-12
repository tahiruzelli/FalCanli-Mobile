import 'dart:io';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/View/UserViews/FortunersView/fortuner_detail_view.dart';
import 'package:falcanli/View/UserViews/VideoCallView/add_photo_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Globals/Widgets/custom_snackbar.dart';
import '../../../View/UserViews/VideoCallView/video_call_view.dart';

class UserFortunerController extends GetxController {
  RxInt filterIndex = 0.obs;

  RxBool fortunersLoading = false.obs;
  RxBool commentsLoading = false.obs;

  RxBool seeComments = false.obs;

  var images = <File>[].obs;
  FortuneType? fortuneType;

  Future getImage() async {
    List<XFile>? image = await ImagePicker().pickMultiImage();
    if (image != null) {
      for (var i = 0; images.length < 3; i++) {
        images.add(File(image[i].path));
      }
      if ((image.length + images.length) > 3) {
        warningSnackBar("En fazla 3 adet fotoğraf yükleyebilirsiniz!");
      }
    }
  }

  void onFortunerCardPressed(
      int index, UserFortunerController fortunerController) {
    Get.to(FortunerDetailView(index, fortunerController));
  }

  Future getComments() async {
    commentsLoading.value = true;

    Future.delayed(const Duration(seconds: 1)).then((value) {
      commentsLoading.value = false;
    });
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
      switch (fortuneType!) {
        case FortuneType.coffee:
          Get.to(AddPhotoView());
          break;
        case FortuneType.astrology:
          break;
        case FortuneType.natalChart:
          startVideoCall();
          break;
        case FortuneType.tarot:
          startVideoCall();
          break;
      }
    }
  }

  Future startVideoCall() async {
    Get.to(VideoCallView());
  }
}
