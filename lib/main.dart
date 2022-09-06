import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/io.dart';
import 'View/GlobalViews/splash_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/status.dart' as status;
import 'dart:async';

void main() async {
  // IO.Socket socket = IO.io(
  //     'wss://test1.p6p9p21gckjvc.eu-central-1.cs.amazonlightsail.com/',
  //     OptionBuilder().setTransports(['websocket']).build());

  // socket.onConnect((_) {
  //   print('connect');
  //   socket.emit('fortuneTellerId', '62e66f3638575899ff7ebcac');
  // });
  // socket.on('returnData', (data) {
  //   print(data);
  //   // handleNewMessage(data);
  // });
  // socket.on('event', (data) => print(data));
  // socket.onDisconnect((_) => print('disconnect'));
  // socket.on('fromServer', (_) => print(_));
  // //When an event recieved from server, data is added to the stream
  // socket.on('event', (data) => data.toString());
  // socket.onDisconnect((_) => print('disconnect'));

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
      ],
      title: 'Fal Canlı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SplashPage(),
    );
  }
}
