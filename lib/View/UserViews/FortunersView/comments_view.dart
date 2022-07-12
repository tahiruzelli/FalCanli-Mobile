import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import '../../../Globals/Widgets/loading_indicator.dart';

class CommentsView extends StatelessWidget {
  late UserFortunerController fortunerController;
  CommentsView(this.fortunerController);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Yorumlar"),
      body: Stack(
        children: [
          GradiendContainer(),
          Obx(
            () => SizedBox(
              height: Get.height,
              width: Get.width,
              child: fortunerController.commentsLoading.value
                  ? LoadingIndicator()
                  : ListView.builder(
                      itemCount: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                  "Cok iyi bi falci butun her seyi bildi aldigi parayi hak ediyor fazlasini bile"),
                              trailing: Text("21/07/22\n13.43"),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
