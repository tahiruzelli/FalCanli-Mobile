import 'package:falcanli/Globals/Utils/date_time.dart';
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
                  : fortunerController.comments.isEmpty
                      ? const Center(
                          child: Text("Bu falcı için henüz yorum yapılmamış"),
                        )
                      : ListView.builder(
                          itemCount: fortunerController.comments.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                child: ListTile(
                                  title: Text(fortunerController
                                          .comments[index].userid ??
                                      ""),
                                  subtitle: Text(
                                    fortunerController
                                            .comments[index].comment ??
                                        "",
                                  ),
                                  trailing: Text(
                                    (fortunerController
                                                .comments[index].sCreatedate
                                                ?.split(" ")[0] ??
                                            "") +
                                        "\n" +
                                        (fortunerController
                                                .comments[index].sCreatedate
                                                ?.split(" ")[1] ??
                                            ""),
                                    textAlign: TextAlign.center,
                                  ),
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
