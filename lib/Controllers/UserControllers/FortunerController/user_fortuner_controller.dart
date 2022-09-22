import 'dart:async';
import 'dart:io';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Utils/exit_app.dart';
import 'package:falcanli/Models/conversation.dart';
import 'package:falcanli/Repository/User/FortunerRepository/fortuner_repository.dart';
import 'package:falcanli/View/UserViews/FortunersView/fortuner_detail_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../Globals/Widgets/custom_snackbar.dart';
import '../../../Models/comment.dart';
import '../../../Models/fortuner.dart';
import '../../../View/UserViews/VideoCallView/video_call_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserFortunerController extends GetxController {
  FortunerRepository fortunerRepository = FortunerRepository();

  late IO.Socket socket;

  RxInt filterIndex = 0.obs;

  RxBool fortunersLoading = false.obs;
  RxBool commentsLoading = false.obs;

  RxBool seeComments = false.obs;
  RxBool isfortunerResponseWaiting = false.obs;

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
    isfortunerResponseWaiting.value = false;
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

  Future onGoLiveWithFortunerButtonPressed() async {
    String? userId = GetStorage().read(userIdKey);
    var result;
    Conversation conversation;
    if (userId == null) {
      exitApp();
    } else if (currentFortuner == null) {
      Get.back();
      warningSnackBar("Falcı seçiminde hata oluştu");
    } else {
      isfortunerResponseWaiting.value = true;
      if (fortuneType == FortuneType.coffee) {
        if (images.length != 3) {
          warningSnackBar("3 adet fotoğraf çekmeniz gerekmektedir");
        } else {
          result = await fortunerRepository.startConversation(
            fortunerTellerId: currentFortuner?.sId ?? "",
            userId: userId,
            conversationType: getFortuneTypeString(fortuneType!),
            photo1: images[0],
            photo2: images[1],
            photo3: images[3],
          );
        }
      } else {
        result = await fortunerRepository.startConversation(
          fortunerTellerId: currentFortuner?.sId ?? "",
          userId: userId,
          conversationType: getFortuneTypeString(fortuneType!),
        );
      }
      if (isHttpOK(result["statusCode"])) {
        conversation = Conversation.fromJson(result['result']);
        Timer(const Duration(minutes: 5), () {
          isfortunerResponseWaiting.value = false;
          warningSnackBar(
              "Falcı gerekli sürede cevap vermedi, isteğiniz kapanmıştır. Daha sonra tekrar deneyiniz");
        });

        socket.emit('fortuneTellerId', {"data": conversation.fortuneTellerId});
        socket.on('returnData', (data) {
          print(data);
          if (data['haveCall']) {
            Get.to(UserVideoCallView(
              token: data['detail']["agoraToken"],
              channelId: currentFortuner?.channelId ?? "",
              conversationId: conversation.sId ?? "",
              fortuneType: fortuneType!,
            ));
          }
        });
      } else {
        warningSnackBar(result["message"]);
      }
    }
  }

  @override
  void onInit() {
    fortuneType = FortuneType.tarot;
    socket = IO.io(
        'https://test1.p6p9p21gckjvc.eu-central-1.cs.amazonlightsail.com/',
        OptionBuilder().setTransports(['websocket']).build());
    super.onInit();
  }
}
