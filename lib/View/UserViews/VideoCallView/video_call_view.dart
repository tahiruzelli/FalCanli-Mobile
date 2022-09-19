// import 'dart:async';
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import 'package:falcanli/Controllers/UserControllers/LiveVideoController/live_video_controller.dart';
// import 'package:falcanli/Globals/Widgets/loading_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'end_video_call.dart';

// class UserVideoCallView extends StatefulWidget {
//   final String token;
//   final String channelId;
//   UserVideoCallView({required this.channelId, required this.token});
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<UserVideoCallView> {
//   String appId = "4bc8ddcf1ed7459d8482cbfa369dfe88";
//   late String token;
//   late String channel;
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;
//   bool muted = false;
//   bool showToolBar = true;
//   List<String> imageLinks = [
//     "https://i2.milimaj.com/i/milliyet/75/0x410/5c8d168007291c1d740169dc.jpg",
//     "https://yt3.ggpht.com/ZKE70cnZjPSLsmojxPB7dZc5g4a2Kc9xRcgflx4LqYSidvLrhL0vj3UShAKqaT1K9WoI79_o=s900-c-k-c0x00ffffff-no-rj",
//     "https://www.medyumbestamihoca.com/wp-content/uploads/2020/05/kahve-fali.jpeg",
//   ];
//   LiveVideoController liveVideoController = Get.put(LiveVideoController());
//   @override
//   void initState() {
//     super.initState();
//     token = widget.token;
//     channel = widget.channelId;
//     initAgora();
//   }

//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();

//     //create the engine
//     _engine = await RtcEngine.create(appId);
//     await _engine.enableVideo();
//     _engine.setEventHandler(
//       RtcEngineEventHandler(
//         joinChannelSuccess: (String channel, int uid, int elapsed) {
//           print("local user $uid joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         userJoined: (int uid, int elapsed) {
//           print("remote user $uid joined");
//           setState(() {
//             _remoteUid = uid;
//           });
//         },
//         userOffline: (int uid, UserOfflineReason reason) {
//           print("remote user $uid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//       ),
//     );

//     await _engine.joinChannel(token, channel, null, 0);
//   }

//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ayşe Fatma'),
//       ),
//       body: Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 showToolBar = !showToolBar;
//               });
//             },
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               color: Colors.transparent,
//             ),
//           ),
//           Center(
//             child: _remoteVideo(),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Card(
//               child: SizedBox(
//                 width: 100,
//                 height: 150,
//                 child: Center(
//                   child: _localUserJoined
//                       ? const RtcLocalView.SurfaceView()
//                       : LoadingIndicator(),
//                 ),
//               ),
//             ),
//           ),
//           showToolBar ? toolbar : photos,
//         ],
//       ),
//     );
//   }

//   Widget get photos {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: SizedBox(
//         height: 150,
//         width: MediaQuery.of(context).size.width,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: List.generate(
//             imageLinks.length,
//             (index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: InkWell(
//                     onTap: () {
//                       Get.dialog(
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: Get.width / 10,
//                             vertical: Get.height / 5,
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   imageLinks[index],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     child: Image.network(
//                       imageLinks[index],
//                       height: 150,
//                       width: MediaQuery.of(context).size.width / 4,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget get toolbar {
//     return Container(
//       alignment: Alignment.bottomCenter,
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           RawMaterialButton(
//             onPressed: _onToggleMute,
//             child: Icon(
//               muted ? Icons.mic_off : Icons.mic,
//               color: muted ? Colors.white : Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: muted ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           ),
//           RawMaterialButton(
//             onPressed: () => _onCallEnd(context),
//             child: const Icon(
//               Icons.call_end,
//               color: Colors.white,
//               size: 35.0,
//             ),
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.redAccent,
//             padding: const EdgeInsets.all(15.0),
//           ),
//           RawMaterialButton(
//             onPressed: _onSwitchCamera,
//             child: const Icon(
//               Icons.switch_camera,
//               color: Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           )
//         ],
//       ),
//     );
//   }

//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return RtcRemoteView.SurfaceView(
//         uid: _remoteUid!,
//         channelId: channel,
//       );
//     } else {
//       return const Text(
//         'Diğer katılımcı bekleniyor',
//         textAlign: TextAlign.center,
//       );
//     }
//   }

//   void _onCallEnd(BuildContext context) {
//     _engine.leaveChannel();
//     Get.offAll(EndVideoCall());
//   }

//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     _engine.muteLocalAudioStream(muted);
//   }

//   void _onSwitchCamera() {
//     _engine.switchCamera();
//   }
// }

import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "4bc8ddcf1ed7459d8482cbfa369dfe88";
const token =
    "007eJxTYFi8XPFmd9hzMQGLGzK/w5cumGqnfjjhtWjNr+xE9SOzl5YpMJgkJVukpCSnGaammJuYWqZYmFgYJSelJRqbWaakpVpYbL2gkGyipJRcx6PLwsgAgSA+L0NiUWJSol5xallKYnEmAwMAuW4jcA==";
const channel = "araba.sevdasi";

class UserVideoCallView extends StatefulWidget {
  String channelId;
  String token;
  UserVideoCallView({required this.channelId, required this.token});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<UserVideoCallView> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
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

    await _engine.joinChannel(token, channel, null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _engine.leaveChannel();
        Navigator.pop(context);
      }),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? RtcLocalView.SurfaceView()
                    : CircularProgressIndicator(),
              ),
            ),
          ),
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
      return Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
