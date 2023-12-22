import 'package:kontent/entities/content.dart';
import 'package:kontent/kontentWidgets/kontent_carousel.dart';

class Carousel {
  String id;
  String title;
  String type;
  KontentCarouselType orientation;
  List<Content> items;

  get getId => id;

  get getTitle => title;

  get getType => type;

  get getOrientation => orientation;

  get getItems => items;

  Carousel(
      {required this.id,
      required this.title,
      required this.type,
      required this.orientation,
      required this.items});

  factory Carousel.fromJson(Map<String, dynamic> json) {
    List<Content> videoList = [];
    for (var contentJson in json['items']) {
      videoList.add(Content.fromJson(contentJson));
    }

    int orientationBool = json['hero'] ?? false;

    return Carousel(
      id: json['id'],
      type: json['type'],
      items: videoList,
      title: json['title'],
      orientation: orientationBool == 1
          ? KontentCarouselType.vertical
          : KontentCarouselType.horizontal,
    );
  }
}
