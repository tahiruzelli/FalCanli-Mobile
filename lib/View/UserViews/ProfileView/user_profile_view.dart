import 'package:falcanli/Globals/Constans/urls.dart';
import 'package:falcanli/Globals/Widgets/detail_line.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/UserControllers/UserProfileController/user_profile_controller.dart';
import '../../../Globals/Constans/colors.dart';

class UserProfileView extends StatelessWidget {
  UserProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradiendContainer(),
          ListView(
            children: [
              const SizedBox(height: 30),
              const CircleAvatar(
                minRadius: 50,
                maxRadius: 100,
                backgroundImage: NetworkImage(emptyUser),
              ),
              const SizedBox(height: 30),
              DetailLine("Adi", "Tahir Uzelli"),
              DetailLine("Dogum Tarihi", "07.12.1999"),
              DetailLine("Burç", "Yay"),
              DetailLine("Kredi Miktarı", "2567"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () => profileController.onLogoutButtonPressed(),
                    padding: const EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    child: const Text(
                      "Çıkış Yap",
                      style: TextStyle(
                        color: colorDanger,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
