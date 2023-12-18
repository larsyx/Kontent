import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:kontent/kontentPages/mediaplayer/kontent_video_player.dart';

enum KontentCarouselType { featured, horizontal, vertical }

final carouselTypeToCarouselHeight = <KontentCarouselType, double>{
  KontentCarouselType.featured: 300,
  KontentCarouselType.horizontal: 100,
  KontentCarouselType.vertical: 400
};

class _KontentCarouselSingleItem extends StatelessWidget {
  final KontentCarouselType type;
  final String title;

  const _KontentCarouselSingleItem({required this.type, required this.title});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: carouselTypeToCarouselHeight[type],
        showIndicator: true,
        slideIndicator: const CircularSlideIndicator(),
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const KontentVideoPlayer()),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(color: Colors.black),
                child: null,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class _KontentCarouselMultipleItem extends StatelessWidget {
  const _KontentCarouselMultipleItem();

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      options: CarouselOptions(
        enlargeCenterPage: false,
        viewportFraction: 0.9,
        showIndicator: true,
        slideIndicator: CircularStaticIndicator(),
      ),
      itemCount: 3,
      itemBuilder: (context, index, realIdx) {
        final first = index * 2;
        final second = first + 1;
        return Row(
          children: [first, second].map((idx) {
            return Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const KontentVideoPlayer()),
                  ),
                  child: Container(
                    color: Colors.black,
                    height: carouselTypeToCarouselHeight[
                        KontentCarouselType.vertical],
                    child: null,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class KontentCarouselWrapper extends StatelessWidget {
  final String title;
  final KontentCarouselType type;

  const KontentCarouselWrapper({
    required this.title,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 5, top: 5),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                title,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            type == KontentCarouselType.vertical
                ? const _KontentCarouselMultipleItem()
                : _KontentCarouselSingleItem(type: type, title: title)
          ]),
    );
  }
}
