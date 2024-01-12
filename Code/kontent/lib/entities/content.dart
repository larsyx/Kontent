import 'package:quiver/core.dart';

class Content {
  String id;
  String title;
  String description;
  String thumbnail;
  String? dash;
  String director;
  String genre;
  int duration;

  get getId => id;

  get getTitle => title;

  get getDescription => description;

  get getThumbnail => thumbnail;

  get getDash => dash;

  get getGenre => genre;

  get getDuration => duration;

  get getDirector => director;

  Content({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.genre,
    required this.duration,
    required this.director,
    this.dash,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    final metaInfo = json['metaInfo'] as Map<String, dynamic>?;

    return Content(
      id: json['id'].toString(),
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
      genre: metaInfo?['genre'] as String,
      duration: metaInfo?['duration'] as int,
      director: metaInfo?['director'] as String,
      dash: metaInfo?['dash'] as String?,
    );
  }

  @override
  bool operator ==(other) =>
      other is Content && title == other.title && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, title.hashCode);
}
