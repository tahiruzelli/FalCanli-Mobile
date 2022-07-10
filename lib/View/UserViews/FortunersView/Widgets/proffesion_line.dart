import 'package:flutter/material.dart';

class ProffessionLine extends StatelessWidget {
  late bool kahve;
  late bool astroloji;
  late bool dogumHaritasi;
  late bool tarot;
  ProffessionLine({
    required this.tarot,
    required this.kahve,
    required this.dogumHaritasi,
    required this.astroloji,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        tarot
            ? Image.asset(
                "assets/icons/tarotIcon.jpeg",
                height: 20,
                width: 20,
              )
            : Image.asset(
                "assets/icons/unselectedTarotIcon.png",
                height: 20,
                width: 20,
              ),
        const SizedBox(width: 5),
        kahve
            ? Image.asset(
                "assets/icons/kahveIcon.jpeg",
                height: 20,
                width: 20,
              )
            : Image.asset(
                "assets/icons/unselectedKahveIcon.png",
                height: 20,
                width: 20,
              ),
        const SizedBox(width: 5),
        astroloji
            ? Image.asset(
                "assets/icons/astrolojiIcon.webp",
                height: 20,
                width: 20,
              )
            : Image.asset(
                "assets/icons/unselectedAstrolojiIcon.png",
                height: 20,
                width: 20,
              ),
        const SizedBox(width: 5),
        dogumHaritasi
            ? Image.asset(
                "assets/icons/dogumHaritasiIcon.jpeg",
                height: 20,
                width: 20,
              )
            : Image.asset(
                "assets/icons/unselectedDogumHaritasiIcon.png",
                height: 20,
                width: 20,
              )
      ],
    );
  }
}
