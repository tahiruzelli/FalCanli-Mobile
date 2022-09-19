import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Constans/urls.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Utils/exit_app.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Globals/Widgets/detail_line.dart';
import 'package:falcanli/Models/conversation.dart';
import 'package:falcanli/Repository/Fortuner/MainRepository/main_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../View/FortunerViews/VideoCallView/fortuner_video_call_view.dart';
import '../../../View/UserViews/VideoCallView/video_call_view.dart';

class FortunerLiveController extends GetxController {
  FortunerMainRepository mainRepository = FortunerMainRepository();

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
      socket.emit('fortuneTellerId', userId);
      print('connect to socket');
    });
    socket.on('returnData', (data) {
      print(data);
      if (data['haveCall'] == true) {
        conversation = Conversation.fromJson(data['detail']);
        showPopUp(conversation);
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

  Future acceptMeet(Conversation conversation) async {
    String? fortunerId = GetStorage().read(userIdKey);
    Get.back();
    var result = await mainRepository.acceptMeet(
      fortunerId: fortunerId!,
      userId: conversation.userid ?? "",
      conversationId: conversation.sId ?? "",
    );
    // meetSocket.onConnect((_) {
    //   socket.emit('conversationId', conversation.sId);
    //   print('connect to meet socket');
    // });
    // meetSocket.on('returnData', (data) {
    //   print("meet socket data");
    //   print(data);
    // });
    // Get.to(FortunerVideoCallView(
    //   channelId: "",
    //   token: conversation.agoraToken ?? "",
    // ));
  }

  Future showPopUp(Conversation conversation) async {
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
                          child:
                              Image.network(emptyUser, height: 40, width: 40),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "Tahir Uzelli - 22 Yaşında",
                        style: TextStyle(
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
              DetailLine("Cinsiyet", "Erkek"),
              DetailLine("İlişki Durumu", "Karışık"),
              DetailLine("Medeni Durum", "Bekar"),
              DetailLine("Burç", "Yay"),
              DetailLine("Ay Burcu", "Terazi"),
              DetailLine("Yükselen", "Aslan"),
              DetailLine("Meslek", "Bilgisayar Mühendisi"),
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
                      onPressed: () => acceptMeet(conversation),
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
