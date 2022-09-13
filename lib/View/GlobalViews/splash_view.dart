import 'dart:async';
import 'package:falcanli/Controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double _currentOpacity = 0.5;
  double opacityLevel = 0;
  static const int durationTime = 3;

  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();

    _controller = AnimationController(
        duration: const Duration(seconds: durationTime),
        vsync: this,
        value: 0.1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startTimer() async {
    Timer(const Duration(seconds: durationTime), () {
      mainController.pushPage();
    });
  }

  Widget initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo_icon.png",
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              curve: Curves.linear,
              opacity: _currentOpacity,
              duration: const Duration(seconds: 5),
            ),
          ],
        ),
      ),
    );
  }
}
