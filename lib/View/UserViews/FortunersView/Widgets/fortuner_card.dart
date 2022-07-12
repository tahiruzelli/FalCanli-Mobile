import 'package:falcanli/Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import 'package:falcanli/View/UserViews/FortunersView/Widgets/proffesion_line.dart';
import 'package:ff_stars/ff_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FortunerCard extends StatelessWidget {
  late int index;
  late bool kahve;
  late bool astroloji;
  late bool dogumHaritasi;
  late bool tarot;
  FortunerCard({
    required this.index,
    required this.tarot,
    required this.kahve,
    required this.dogumHaritasi,
    required this.astroloji,
  });
  UserFortunerController fortunerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Card(
        child: ListTile(
          onTap: () => fortunerController.onFortunerCardPressed(
              index, fortunerController),
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.turuncufalcafe.com/fal-fotograflar/2019/03/falcihelen.jpg"),
          ),
          title: const Text("Ayse Fatma"),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FFStars(
                normalStar: Image.asset("assets/icons/unselectedStar.png"),
                selectedStar: Image.asset("assets/icons/selectedStar.png"),
                step: 0.01,
                defaultStars: 4.3,
                justShow: true,
                // starCount: 5,
                starHeight: 20,
                starWidth: 20,
                starMargin: 3,
                // justShow: true,
                // followChange: true,
              ),
              const SizedBox(height: 5),
              ProffessionLine(
                tarot: tarot,
                kahve: kahve,
                dogumHaritasi: dogumHaritasi,
                astroloji: astroloji,
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("127"),
                    Image.asset(
                      "assets/icons/coinIcon.png",
                      height: 20,
                      width: 20,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
              index % 3 == 2
                  ? const Text(
                      "Müsait",
                      style: TextStyle(color: Colors.green),
                    )
                  : index % 3 == 1
                      ? const Text(
                          "Görüşmede",
                          style: TextStyle(color: Colors.orange),
                        )
                      : const Text(
                          "Müsait Değil",
                          style: TextStyle(color: Colors.red),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
