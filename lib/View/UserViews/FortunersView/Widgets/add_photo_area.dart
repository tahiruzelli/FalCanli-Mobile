import 'package:falcanli/Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Globals/Constans/colors.dart';

class PhotoArea extends StatelessWidget {
  UserFortunerController fortunerController = Get.find();
  int maxResim = 3;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.18,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ListView.builder(
            scrollDirection: Axis.horizontal,
            // ignore: unnecessary_null_comparison
            itemCount: fortunerController.images.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 120,
                child: InkWell(
                  onTap: () {
                    if (index == fortunerController.images.length &&
                        fortunerController.images.length < maxResim) {
                      fortunerController.getImage();
                    }
                  },
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: 120,
                        color: Colors.grey.shade100,
                        // ignore: unnecessary_null_comparison
                        child: fortunerController.images.length != null
                            ? (index < fortunerController.images.length
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Image.file(
                                        fortunerController.images[index],
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          maxResim -
                                                      fortunerController
                                                          .images.length ==
                                                  0
                                              ? "Daha fazla fotoğraf ekleyemezsiniz!"
                                              : "${maxResim - fortunerController.images.length} tane daha fotoğraf ekliyebilirsiniz.",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: Get.width * 0.03,
                                            fontWeight: FontWeight.normal,
                                            color: mainColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  index == 0
                                      ? const Icon(Icons.add_a_photo)
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Fotoğraf yüklemek için tıklayın",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: Get.width * 0.03,
                                              fontWeight: FontWeight.normal,
                                              color: mainColor,
                                            ),
                                          ),
                                        )
                                ],
                              ),
                      ),
                      Visibility(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              if (index !=
                                  fortunerController.images.length) {
                                fortunerController.images.removeAt(index);
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        visible: index != fortunerController.images.length
                            ? true
                            : false,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
