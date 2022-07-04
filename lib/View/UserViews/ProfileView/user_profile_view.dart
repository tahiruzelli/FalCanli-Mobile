import 'package:falcanli/Globals/Widgets/detail_line.dart';
import 'package:falcanli/Globals/Widgets/gradiend_container.dart';
import 'package:flutter/material.dart';

class UserProfileView extends StatelessWidget {
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
                backgroundImage: NetworkImage(
                  "https://www.neoldu.com/d/other/ruyada-insan-gormek-001.jpg",
                ),
              ),
              const SizedBox(height: 30),
              DetailLine("Adi", "Tahir Uzelli"),
              DetailLine("Dogum Tarihi", "07.12.1999"),
              DetailLine("Burç", "Yay"),
              DetailLine("Kredi Miktarı", "2567"),
            ],
          ),
        ],
      ),
    );
  }
}
