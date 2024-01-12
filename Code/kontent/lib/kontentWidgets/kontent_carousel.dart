import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:kontent/entities/carousel.dart';
import 'package:kontent/entities/content.dart';
import 'package:kontent/kontentPages/mediaplayer/kontent_content_detail_page.dart';

enum KontentCarouselType { featured, horizontal, vertical }

final carouselTypeToCarouselHeight = <KontentCarouselType, double>{
  KontentCarouselType.featured: 300,
  KontentCarouselType.horizontal: 200,
  KontentCarouselType.vertical: 400
};

class _KontentCarouselSingleItem extends StatelessWidget {
  final Carousel carousel;

  const _KontentCarouselSingleItem({required this.carousel});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: carouselTypeToCarouselHeight[KontentCarouselType.featured],
        showIndicator: true,
        slideIndicator: const CircularSlideIndicator(),
      ),
      items: carousel.getItems.map<Widget>((Content i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        KontentContentDetailPageBodyWidget(content: i)),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage(i.thumbnail), fit: BoxFit.cover)),
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
  final Carousel carousel;

  const _KontentCarouselMultipleItem({required this.carousel});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      options: CarouselOptions(
        height: carouselTypeToCarouselHeight[carousel.getOrientation],
        enlargeCenterPage: false,
        viewportFraction: 0.9,
        showIndicator: true,
        slideIndicator: CircularStaticIndicator(),
      ),
      itemCount: carousel.items.length,
      itemBuilder: (context, index, realIdx) {
        final item = carousel.items[index];
        return Row(children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          KontentContentDetailPageBodyWidget(content: item)),
                ),
                child: Container(
                  color: Colors.black,
                  height: carouselTypeToCarouselHeight[carousel.getOrientation],
                  child: Image.network(
                    item.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ]);
      },
    );
  }
}

class KontentCarouselWrapper extends StatelessWidget {
  final Carousel carousel;

  const KontentCarouselWrapper({
    required this.carousel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 5, top: 5),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            carousel.title,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        carousel.items.length > 1
            ? _KontentCarouselMultipleItem(
                carousel: carousel,
              )
            : _KontentCarouselSingleItem(
                carousel: carousel,
              )
      ]),
    );
  }
}
