import 'package:flutter/material.dart';
import 'package:kontent/entities/carousel.dart';
import 'package:kontent/entities/content.dart';
import 'package:kontent/kontentWidgets/kontent_carousel.dart';

class KontentHomePageBodyWidget extends StatelessWidget {
  const KontentHomePageBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            KontentCarouselWrapper(
              carousel: Carousel(
                  id: '',
                  title: 'Featured',
                  type: '',
                  orientation: KontentCarouselType.vertical,
                  items: List<Content>.empty()),
            ),
            KontentCarouselWrapper(
              carousel: Carousel(
                  id: '',
                  title: 'Movies',
                  type: '',
                  orientation: KontentCarouselType.vertical,
                  items: List<Content>.empty()),
            ),
            KontentCarouselWrapper(
              carousel: Carousel(
                  id: '',
                  title: 'Tv Series',
                  type: '',
                  orientation: KontentCarouselType.vertical,
                  items: List<Content>.empty()),
            )
          ],
        ),
      ),
    );
  }
}
