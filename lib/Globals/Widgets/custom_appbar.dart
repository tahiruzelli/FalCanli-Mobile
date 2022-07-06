import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

AppBar customAppBar({
  String title = "",
  Widget? action,
  AdvancedDrawerController? advancedDrawerController,
}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    backgroundColor: mainColor,
    actions: [
      action ?? Container(),
    ],
    leading: advancedDrawerController == null
        ? null
        : IconButton(
            onPressed: () {
              advancedDrawerController.showDrawer();
            },
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
  );
}
