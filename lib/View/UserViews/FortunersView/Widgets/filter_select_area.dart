import 'package:falcanli/Controllers/UserControllers/FortunerController/fortuner_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class FilterSelectArea extends StatelessWidget {
  late FortunerController fortunerController;
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
                filterArea(0, "Tarot"),
                filterArea(1, "Kahve"),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                filterArea(2, "Astroloji"),
                filterArea(3, "Doğum Haritası"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget filterArea(int index, String title) {
    return Expanded(
      child: SizedBox(
        child: InkWell(
          onTap: () {
            fortunerController.filterIndex.value = index;
            fortunerController.getFortunerList();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  child: Center(
                      child: Obx(
                    () => Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            fortunerController.filterIndex.value == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  )),
                ),
              ),
              Obx(
                () => Divider(
                  color: fortunerController.filterIndex.value == index
                      ? mainColor
                      : Colors.transparent,
                ),
              )
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
