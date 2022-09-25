import 'dart:async';
import 'dart:io';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Utils/exit_app.dart';
import 'package:falcanli/Globals/global_vars.dart';
import 'package:falcanli/Models/conversation.dart';
import 'package:falcanli/Repository/User/CreditRepository/user_credit_repository.dart';
import 'package:falcanli/Repository/User/FortunerRepository/fortuner_repository.dart';
import 'package:falcanli/Repository/User/ProfileRepository/user_profile_repository.dart';
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
  late IO.Socket meetSocket;

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
  int? currentAmount;

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

  Future<bool> isUserHaveEnoughCredit(String userId) async {
    var response = await UserProfileRepository().getUserCredit(userId);
    int currentCredit = response['result']['remainingCredit'];
    switch (fortuneType!) {
      case FortuneType.coffee:
        currentAmount = currentFortuner!.coffeeServiceFee!;
        if (currentCredit >= currentAmount!) {
          return true;
        } else {
          errorSnackBar("Yeterli krediniz bulunmamaktadir");
          return false;
        }
      case FortuneType.astrology:
        currentAmount = currentFortuner!.astrologyServiceFee!;
        if (currentCredit >= currentAmount!) {
          return true;
        } else {
          errorSnackBar("Yeterli krediniz bulunmamaktadir");
          return false;
        }
      case FortuneType.natalChart:
        currentAmount = currentFortuner!.birthChartServiceFee!;
        if (currentCredit >= currentAmount!) {
          return true;
        } else {
          errorSnackBar("Yeterli krediniz bulunmamaktadir");
          return false;
        }
      case FortuneType.tarot:
        currentAmount = currentFortuner!.tarotServiceFee!;
        if (currentCredit >= currentAmount!) {
          return true;
        } else {
          errorSnackBar("Yeterli krediniz bulunmamaktadir");
          return false;
        }
    }
  }

  void onFortunerCardPressed(
      UserFortunerController fortunerController, Fortuner fortuner) {
    currentFortuner = fortuner;
    isfortunerResponseWaiting.value = false;
    Get.to(FortunerDetailView(fortunerController));
  }

  Future endCall(
      {required String conversationId, int? point, String? comment}) async {
    fortunerRepository.endConversation(conversationId);
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
    } else if (await isUserHaveEnoughCredit(userId)) {
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
            photo3: images[2],
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
        socket.close();
        socket = IO.io(
            'https://test1.p6p9p21gckjvc.eu-central-1.cs.amazonlightsail.com/',
            OptionBuilder().setTransports(['websocket']).build());
        socket.emit('fortuneTellerId', {"data": conversation.fortuneTellerId});
        socket.on('returnData', (data) {
          print(data);
          var firstSocketData = data;
          if (data['haveCall']) {
            meetSocket.close();
            meetSocket = IO.io(
                'https://test1.p6p9p21gckjvc.eu-central-1.cs.amazonlightsail.com/',
                OptionBuilder().setTransports(['websocket']).build());
            meetSocket.emit("conversationId", {"data": conversation.sId});
            print(conversation.sId);
            meetSocket.on("returnData", (data) {
              print(data);
              if (data['goingCall']) {
                print("go to call");
                shouldReInitVideo = true;
                isfortunerResponseWaiting.value = false;
                UserCreditRepository().spendCredit(
                  amount: currentAmount ?? 0,
                  userId: userId,
                  fortuneTellerId: currentFortuner?.sId ?? "",
                );
                Get.to(UserVideoCallView(
                  token: firstSocketData['detail']["agoraToken"],
                  channelId: currentFortuner?.channelId ?? "",
                  conversationId: conversation.sId ?? "",
                  uid: firstSocketData['detail']['agoraTokenUid'] ?? 1,
                  fortuneType: fortuneType!,
                  userFortunerController: this,
                ));
              }
            });
          }
        });
      } else {
        warningSnackBar(result["message"]);
      }
    }
  }

  @override
  void onInit() {
    fortuneType = FortuneType.coffee;
    socket = IO.io(
        'https://test1.p6p9p21gckjvc.eu-central-1.cs.amazonlightsail.com/',
        OptionBuilder().setTransports(['websocket']).build());
    meetSocket = IO.io(
        'https://test1.p6p9p21gckjvc.eu-central-1.cs.amazonlightsail.com/',
        OptionBuilder().setTransports(['websocket']).build());
    super.onInit();
  }
}
