import 'package:falcanli/Controllers/UserControllers/FortunerController/user_fortuner_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Constans/enums.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FilterSelectArea extends StatelessWidget {
  late UserFortunerController fortunerController;
  FilterSelectArea(this.fortunerController);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                filterArea(0, "Kahve", "assets/icons/kahveIcon.jpeg"),
                filterArea(1, "Tarot", "assets/icons/tarotIcon.jpeg"),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                filterArea(2, "Astroloji", "assets/icons/astrolojiIcon.webp"),
                filterArea(
                    3, "Doğum Haritası", "assets/icons/dogumHaritasiIcon.jpeg"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget filterArea(int index, String title, String path) {
    return Expanded(
      child: SizedBox(
        child: InkWell(
          onTap: () {
            if (index == 0) {
              fortunerController.fortuneType = FortuneType.coffee;
            } else if (index == 1) {
              fortunerController.fortuneType = FortuneType.tarot;
            } else if (index == 2) {
              fortunerController.fortuneType = FortuneType.astrology;
            } else if (index == 3) {
              fortunerController.fortuneType = FortuneType.natalChart;
            } else {
              errorSnackBar(
                  "Bir hata alındı. Sistem bu hatayı otomatik olarak raporladı.");
            }

            fortunerController.filterIndex.value = index;
            fortunerController.getFortunerList();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: fortunerController.filterIndex.value == index
                            ? iosGreyColor
                            : Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(
                                path,
                                height: 35,
                                width: 35,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 20,
                                color: iosGreyColor,
                                fontWeight:
                                    fortunerController.filterIndex.value ==
                                            index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Obx(
              //   () => Divider(
              //     color: fortunerController.filterIndex.value == index
              //         ? iosGreyColor
              //         : Colors.transparent,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// class FilterArea extends StatelessWidget {
//   late int index;
//   late String title;
//   FilterArea(this.index, this.title);
//   FortunerController fortunerController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SizedBox(
//         child: InkWell(
//           onTap: () {
//             fortunerController.filterIndex.value = index;
//             fortunerController.getFortunerList();
//           },
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: SizedBox(
//                   child: Center(
//                       child: Obx(
//                     () => Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight:
//                             fortunerController.filterIndex.value == index
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                       ),
//                     ),
//                   )),
//                 ),
//               ),
//               Obx(
//                 () => Divider(
//                   color: fortunerController.filterIndex.value == index
//                       ? mainColor
//                       : Colors.transparent,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
