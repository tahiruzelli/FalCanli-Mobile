import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../Globals/Constans/colors.dart';

class IntroSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 15.0),
          CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: [
              carouselPage(
                "Geleceğiniz hakkında tahminlere erişin!",
                "Falcılarımızla görüşerek sizin hakkında tahminler bulunmalarına izin verin",
              ),
              carouselPage(
                "Fal Çeşitleri?",
                "Farklı fal çeşitlerimiz ile istediğiniz fal çeşidini istediğiniz falcıya baktırarak çeşitlilik hakkına sahip olun!",
              ),
              carouselPage(
                "Sınırsız Görüşme",
                "Sizi belli bir süreye kısıtlamayarak falcılarımız ne kadar isterse o kadar görüşme hakkına sahipsiniz!",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget carouselPage(String title, String subTitle) {
    return Container(
      decoration: BoxDecoration(
        color: iosGreyColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              subTitle,
              style: const TextStyle(
                color: mainColor,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
