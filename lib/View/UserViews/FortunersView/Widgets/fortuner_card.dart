import 'package:falcanli/Controllers/UserControllers/FortunerController/fortuner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FortunerCard extends StatelessWidget {
  late int index;
  FortunerCard(this.index);
  FortunerController fortunerController = Get.put(FortunerController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          onTap: () => fortunerController.onFortunerCardPressed(),
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.turuncufalcafe.com/fal-fotograflar/2019/03/falcihelen.jpg"),
          ),
          title: const Text("Ayse Fatma"),
          subtitle: const Text("Tarot - Kahve\n4/10"),
          trailing: index % 2 == 0
              ? const Text(
                  "Müsait",
                  style: TextStyle(color: Colors.green),
                )
              : const Text(
                  "Müsait Değil",
                  style: TextStyle(color: Colors.red),
                ),
        ),
      ),
    );
  }
}
