import 'dart:io';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Repository/User/FortunerRepository/fortuner_repository.dart';
import 'package:falcanli/View/UserViews/FortunersView/fortuner_detail_view.dart';
import 'package:falcanli/View/UserViews/VideoCallView/add_photo_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Globals/Widgets/custom_snackbar.dart';
import '../../../Models/comment.dart';
import '../../../Models/fortuner.dart';
import '../../../View/UserViews/VideoCallView/video_call_view.dart';

class UserFortunerController extends GetxController {
  FortunerRepository fortunerRepository = FortunerRepository();

  RxInt filterIndex = 0.obs;

  RxBool fortunersLoading = false.obs;
  RxBool commentsLoading = false.obs;

  RxBool seeComments = false.obs;

  List<Fortuner> fortunerList = [];

  var images = <File>[].obs;
  FortuneType? fortuneType;
  Fortuner? currentFortuner;
  List<Comment> comments = [];

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
      UserFortunerController fortunerController, Fortuner fortuner) {
    currentFortuner = fortuner;
    Get.to(FortunerDetailView(fortunerController));
  }

  Future getComments() async {
    comments.clear();
    commentsLoading.value = true;
    fortunerRepository.getComments(currentFortuner?.sId ?? "").then((value) {
      if (isHttpOK(value['statusCode'])) {
        comments =
            (value['result'] as List).map((e) => Comment.fromJson(e)).toList();
      } else {
        warningSnackBar(value['message']);
      }
      commentsLoading.value = false;
    });
  }

  Future getFortunerList() async {
    fortunersLoading.value = true;
    fortunerRepository
        .getFortuner(
      astroloji: fortuneType == FortuneType.astrology ? true : false,
      dogumharitasi: fortuneType == FortuneType.natalChart ? true : false,
      kahve: fortuneType == FortuneType.coffee ? true : false,
      tarot: fortuneType == FortuneType.tarot ? true : false,
    )
        .then((value) {
      if (isHttpOK(value['statusCode'])) {
        fortunerList =
            (value['result'] as List).map((e) => Fortuner.fromJson(e)).toList();
      } else {}
      fortunersLoading.value = false;
    });
  }

  Future onGoLiveWithFortunerButtonPressed(int index) async {
    if (index == 2) {
      Get.defaultDialog(
          title: "Uyarı",
          middleText:
              "Falcımız şu an müsait değil fakat üzülme. Başka falcılarımız sizi bekliyor!");
    } else if (index == 1) {
      Get.defaultDialog(
          title: "Uyarı",
          middleText:
              "Falcımız şu an başka biri ile görüşüyor ama üzülme. Başka falcılarımız sizi bekliyor!");
    } else if (index == 0) {
      switch (fortuneType!) {
        case FortuneType.coffee:
          Get.to(AddPhotoView());
          break;
        case FortuneType.astrology:
          startVideoCall();
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
    Get.to(UserVideoCallView());
  }

  @override
  void onInit() {
    fortuneType = FortuneType.tarot;
    super.onInit();
  }
}
