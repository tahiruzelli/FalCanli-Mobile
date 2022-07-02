import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/Globals/Widgets/detail_line.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:flutter/material.dart';

class FortunerDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Ayşa Fatma"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Falcı ile görüş!"),
        backgroundColor: mainColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          GradiendContainer(),
          ListView(
            children: [
              const SizedBox(height: 30),
              const CircleAvatar(
                minRadius: 50,
                maxRadius: 100,
                backgroundImage: NetworkImage(
                  "https://play-lh.googleusercontent.com/mwLEUp9QssZBnOZPcfAeRULCU2550Ofa_WK5CY9Omo8LHlrY08_h1BnXzKyHp9_zhfzg",
                ),
              ),
              const SizedBox(height: 30),
              DetailLine("İsim", "Ayşe Fatma"),
              DetailLine("Uzmanlık", "Tarot, kahve"),
              DetailLine("Yaş", "35"),
              DetailLine("Puan", "8.2/10"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet ",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
           Center(
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: Text(
                "Müsait Değil",
                style: TextStyle(
                  fontSize: 75,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.withAlpha(50),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
