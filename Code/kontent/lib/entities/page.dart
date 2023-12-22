import 'package:kontent/entities/carousel.dart';

class Page {
  int id;
  String alias;
  String name;
  List<Carousel> carousels;

  int get getId => id;

  get getAlias => alias;

  get getName => name;

  get getCarousels => carousels;

  Page(
      {required this.id,
      required this.alias,
      required this.name,
      required this.carousels});

  factory Page.fromJson(Map<String, dynamic> json) {
    List<Carousel> contentList = [];
    for (var contentJson in json['content']) {
      contentList.add(Carousel.fromJson(contentJson));
    }

    return Page(
      id: json['id'],
      alias: json['alias'],
      name: json['nome'],
      carousels: contentList,
    );
  }
}
