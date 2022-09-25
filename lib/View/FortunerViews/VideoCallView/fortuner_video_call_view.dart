import 'dart:async';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Repository/User/FortunerRepository/fortuner_repository.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../Globals/Constans/enums.dart';
import '../../../Globals/Widgets/custom_appbar.dart';
import '../../../Globals/Widgets/loading_indicator.dart';

const String appId = "4bc8ddcf1ed7459d8482cbfa369dfe88";
String token =
    "007eJxTYFi8XPFmd9hzMQGLGzK/w5cumGqnfjjhtWjNr+xE9SOzl5YpMJgkJVukpCSnGaammJuYWqZYmFgYJSelJRqbWaakpVpYbL2gkGyipJRcx6PLwsgAgSA+L0NiUWJSol5xallKYnEmAwMAuW4jcA==";
String channel = "araba.sevdasi";

class FortunerVideoCallView extends StatefulWidget {
  String channelId;
  String token;
  String conversationId;
  FortuneType fortuneType;
  int uid;
  FortunerVideoCallView({
    required this.channelId,
    required this.token,
    required this.conversationId,
    required this.fortuneType,
    required this.uid,
  });
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FortunerVideoCallView> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  final _infoStrings = <String>[];

  late IO.Socket meetSocket;
  bool showToolBar = true;

  List<String> imageLinks = [];

  bool muted = false;

  @override
  void initState() {
    super.initState();
    token = widget.token;
    channel = widget.channelId;
    openSocket();
    // initAgora();
    initialize();
  }

  void openSocket() {
    meetSocket = IO.io(
        'https://test1.p6p9p21gckjvc.eu-central-1.cs.amazonlightsail.com/',
        OptionBuilder().setTransports(['websocket']).build());
    meetSocket.onConnect((data) {
      meetSocket.emit("conversationId", {"data": widget.conversationId});
    });
    meetSocket.on("returnData", (data) {
      if (data['goingCall'] == false) {
        warningSnackBar("Görüşme sonlandırılmıştır");
        // _onCallEnd(context);
      } else if (widget.fortuneType == FortuneType.coffee) {
        if (data['photo1'] != "") {
          imageLinks.add(data["detail"]['photo1']);
        }
        if (data['photo2'] != "") {
          imageLinks.add(data["detail"]['photo2']);
        }
        if (data['photo3'] != "") {
          imageLinks.add(data["detail"]['photo3']);
        }
      }
    });
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = const VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(token, channel, null, widget.uid);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.Communication);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
            _onCallEnd(context);
          });
        },
      ),
    );
    // _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
    //   setState(() {
    //     final info = 'onError: $code';
    //     _infoStrings.add(info);
    //   });
    // }, joinChannelSuccess: (channel, uid, elapsed) {
    //   setState(() {
    //     final info = 'onJoinChannel: $channel, uid: $uid';
    //     _infoStrings.add(info);
    //   });
    // }, leaveChannel: (stats) {
    //   setState(() {
    //     _infoStrings.add('onLeaveChannel');
    //     _users.clear();
    //   });
    // }, userJoined: (uid, elapsed) {
    //   setState(() {
    //     final info = 'userJoined: $uid';
    //     _infoStrings.add(info);
    //     _users.add(uid);
    //   });
    // }, userOffline: (uid, elapsed) {
    //   setState(() {
    //     final info = 'userOffline: $uid';
    //     _infoStrings.add(info);
    //     _users.remove(uid);
    //   });
    // }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
    //   setState(() {
    //     final info = 'firstRemoteVideo: $uid ${width}x $height';
    //     _infoStrings.add(info);
    //   });
    // }));
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(appId);
    // RtcEngineContext context = RtcEngineContext(appId);
    // _engine = await RtcEngine.createWithContext(context);

    // await _engine.setChannelProfile(ChannelProfile.Communication);
    // await _engine.setClientRole(ClientRole.Broadcaster);
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
    await _engine.enableVideo();
    await _engine.joinChannel(token, channel, null, widget.uid).then((value) {
      print("fortuner joined channel ");
    });
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Araba Sevdasi"),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showToolBar = !showToolBar;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
          ),
          Center(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    showToolBar = !showToolBar;
                  });
                },
                child: _remoteVideo()),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Card(
              child: SizedBox(
                width: 100,
                height: 150,
                child: Center(
                  child: _localUserJoined
                      ? const RtcLocalView.SurfaceView()
                      : LoadingIndicator(),
                ),
              ),
            ),
          ),
          showToolBar
              ? toolbar
              : widget.fortuneType == FortuneType.coffee
                  ? photos
                  : Container(),
        ],
      ),
    );
  }

  Widget get photos {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            imageLinks.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Get.dialog(
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width / 10,
                            vertical: Get.height / 5,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  imageLinks[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      imageLinks[index],
                      height: 150,
                      width: MediaQuery.of(context).size.width / 4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get toolbar {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: channel,
      );
    } else {
      return const Text(
        'Diğer katılımcı bekleniyor',
        textAlign: TextAlign.center,
      );
    }
  }

  void _onCallEnd(BuildContext context) {
    // _engine.leaveChannel();
    _engine.leaveChannel();
    FortunerRepository fortunerRepository = FortunerRepository();
    fortunerRepository.endConversation(widget.conversationId).then((value) {
      print(value);
      print(widget.conversationId);
    });
    meetSocket.close();
    Get.back();
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }
}
