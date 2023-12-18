import 'package:flutter/material.dart';
import 'package:kontent/kontentWidgets/kontent_carousel.dart';

class KontentHomePageBodyWidget extends StatelessWidget {
  const KontentHomePageBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            KontentCarouselWrapper(
                title: 'Featured', type: KontentCarouselType.featured),
            KontentCarouselWrapper(
                title: 'Movies', type: KontentCarouselType.horizontal),
            KontentCarouselWrapper(
                title: 'Tv Series', type: KontentCarouselType.vertical)
          ],
        ),
      ),
    );
  }
}
