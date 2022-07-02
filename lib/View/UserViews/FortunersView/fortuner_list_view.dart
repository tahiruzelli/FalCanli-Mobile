import 'package:falcanli/Controllers/UserControllers/FortunerController/fortuner_controller.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'Widgets/fortuner_card.dart';

class FortunerListView extends StatelessWidget {
  FortunerController fortunerController = Get.put(FortunerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradiendContainer(),
          ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return FortunerCard(index);
            },
          ),
        ],
      ),
    );
  }
}
