import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Constans/urls.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Utils/exit_app.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Globals/Widgets/detail_line.dart';
import 'package:falcanli/Models/conversation.dart';
import 'package:falcanli/Models/fortuner.dart';
import 'package:falcanli/Models/user.dart';
import 'package:falcanli/Repository/Fortuner/MainRepository/main_repository.dart';
import 'package:falcanli/Repository/User/ProfileRepository/user_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../View/FortunerViews/VideoCallView/fortuner_video_call_view.dart';

class FortunerLiveController extends GetxController {
  FortunerMainRepository mainRepository = FortunerMainRepository();
  UserProfileRepository profileRepository = UserProfileRepository();

  RxBool isFortunerOnline = false.obs;
  late IO.Socket socket;

  // late IO.Socket meetSocket;

  void changeAvailable() {
    if (isFortunerOnline.value) {
      _setNotAvailable();
    } else {
      _setAvailable();
    }
  }

  Future _setAvailable() async {
    String? userId = GetStorage().read(userIdKey);
    if (userId == null) {
      warningSnackBar("Bir hata ile karşılaşıldı. Çıkış yapılıyor.");
      exitApp();
    } else {
      mainRepository.setAvailable(userId).then((value) {
        if (isHttpOK(value['statusCode'])) {
          isFortunerOnline.value = true;
          openSocket();
        } else {
          errorSnackBar(value['message']);
        }
      });
    }
    // Get.to(FortunerVideoCallView(
    //   token:
    //       "0064bc8ddcf1ed7459d8482cbfa369dfe88IABSVSMrmk81a0l5vB/C6Ai1DPBSJhOz4vFXN1qxXQecUQYf3+6379yDEACEsEmklB0iYwEAAQAk2iBj",
    //   channelId: "araba.sevdasi",
    // ));
  }

  Future _setNotAvailable() async {
    String? userId = GetStorage().read(userIdKey);
    if (userId == null) {
      warningSnackBar("Bir hata ile karşılaşıldı. Çıkış yapılıyor.");
      exitApp();
    } else {
      mainRepository.setNotAvailable(userId).then((value) {
        if (isHttpOK(value['statusCode'])) {
          isFortunerOnline.value = false;
          closeSocket();
        } else {
          errorSnackBar(value['message']);
        }
      });
    }
  }

  Future openSocket() async {
    String? userId = GetStorage().read(userIdKey);
    Conversation conversation;
    socket.onConnect((_) {
      socket.emit('fortuneTellerId', {"data": userId});
      print('connect to socket');
    });
    socket.on('returnData', (data) async {
      print(data);
      if (data['haveCall'] == true) {
        conversation = Conversation.fromJson(data['detail']);
        var userResult =
            await profileRepository.getProfileDatas(conversation.userid ?? "");
        User user = User.fromJson(userResult['result']);
        showPopUp(conversation, user, data['detail']['agoraTokenUid'] ?? 1);
      } else {
        print("test3");
      }
    });
  }

  Future closeSocket() async {
    socket.close();
  }

  Future declineMeet(Conversation conversation) async {
    String? fortunerId = GetStorage().read(userIdKey);
    mainRepository.declineMeet(
      fortunerId: fortunerId!,
      userId: conversation.userid ?? "",
      conversationId: conversation.sId ?? "",
    );
    Get.back();
  }

  Future acceptMeet(Conversation conversation, int uid) async {
    String? fortunerId = GetStorage().read(userIdKey);
    Get.back();
    var result = await mainRepository.acceptMeet(
      fortunerId: fortunerId!,
      userId: conversation.userid ?? "",
      conversationId: conversation.sId ?? "",
    );
    print(result);
    if (isHttpOK(result["statusCode"])) {
      var fortunerDataResult =
          await mainRepository.getFortunerDataWithUserId(fortunerId);
      if (isHttpOK(fortunerDataResult['statusCode'])) {
        Fortuner fortuner = Fortuner.fromJson(fortunerDataResult['result']);
        Get.to(FortunerVideoCallView(
          channelId: fortuner.channelId ?? "",
          token: conversation.agoraToken ?? "",
          conversationId: conversation.sId ?? "",
          fortuneType: conversation.conversationType! == "tarot"
              ? FortuneType.tarot
              : conversation.conversationType! == "kahve"
                  ? FortuneType.coffee
                  : conversation.conversationType! == "astroloji"
                      ? FortuneType.astrology
                      : FortuneType.natalChart,
          uid: uid,
        ));
      } else {
        warningSnackBar("Bir sorun olustu daha sonra tekrar deneyin");
      }
    } else {
      warningSnackBar(result['message']);
    }
  }

  Future showPopUp(Conversation conversation, User user, int uid) async {
    try {
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/sounds/phone-ring.mp3"),
      );
    } catch (t) {
      //stream unreachable
    }
    return Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05,
          vertical: Get.height * 0.15,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: iosGreyColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          child: Image.network(user.photo ?? emptyUser,
                              height: 40, width: 40),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        user.name! +
                            " - " +
                            (DateTime.now().year -
                                    DateTime.parse(user.birthday ?? "").year)
                                .toString() +
                            " Yaşında",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DetailLine("Cinsiyet", user.gender ?? ""),
              // DetailLine("İlişki Durumu", "Karışık"),
              // DetailLine("Medeni Durum", "Bekar"),
              DetailLine("Burç", user.zodiac ?? ""),
              // DetailLine("Ay Burcu", "Terazi"),
              // DetailLine("Yükselen", "Aslan"),
              // DetailLine("Meslek", "Bilgisayar Mühendisi"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    width: Get.width / 3,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 15)),
                      ),
                      onPressed: () => declineMeet(conversation),
                      child: const Text(
                        "Reddet",
                        style: TextStyle(
                          color: colorDanger,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    width: Get.width / 3,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 15)),
                      ),
                      onPressed: () => acceptMeet(conversation, uid),
                      child: const Text(
                        "Kabul Et",
                        style: TextStyle(
                          color: colorSuccess,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onInit() {
    super.onInit();
    socket = IO.io(
        'wss://test1.p6p9p21gckjvc.eu-central-1.cs.amazonlightsail.com/',
        OptionBuilder().setTransports(['websocket']).build());
    // meetSocket = IO.io(
    //     'wss://test1.p6p9p21gckjvc.eu-central-1.cs.amazonlightsail.com/',
    //     OptionBuilder().setTransports(['websocket']).build());
    _setAvailable();
    isFortunerOnline.value = false;
  }
}
