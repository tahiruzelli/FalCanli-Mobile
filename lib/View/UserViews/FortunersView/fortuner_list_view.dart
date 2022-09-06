import 'package:falcanli/Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:falcanli/Globals/Widgets/loading_indicator.dart';
import 'package:falcanli/View/UserViews/FortunersView/Widgets/filter_select_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import 'Widgets/fortuner_card.dart';

class FortunerListView extends StatelessWidget {
  UserFortunerController fortunerController = Get.put(UserFortunerController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => fortunerController.getFortunerList(),
      child: Scaffold(
        body: Stack(
          children: [
            GradiendContainer(),
            Column(
              children: [
                const SizedBox(height: 10),
                FilterSelectArea(fortunerController),
                Obx(
                  () => Expanded(
                    child: SizedBox(
                      child: fortunerController.fortunersLoading.value
                          ? Center(
                              child: LoadingIndicator(),
                            )
                          : ListView.builder(
                              itemCount: fortunerController.fortunerList.length,
                              itemBuilder: (context, index) {
                                return FortunerCard(
                                  fortuner:
                                      fortunerController.fortunerList[index],
                                  fortunerController: fortunerController,
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
