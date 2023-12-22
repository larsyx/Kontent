class Content {
  String id;
  String title;
  String description;
  String thumbnail;
  String? hls;
  String? dash;
  String? progressive;
  String genre;
  int duration;

  get getId => id;

  get getTitle => title;

  get getDescription => description;

  get getThumbnail => thumbnail;

  get getHls => hls;

  get getDash => dash;

  get getProgressive => progressive;

  get getGenre => genre;

  get getDuration => duration;

  Content({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.genre,
    required this.duration,
    this.hls,
    this.dash,
    this.progressive,
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
      hls: metaInfo?['hls'] as String?,
      dash: metaInfo?['dash'] as String?,
      progressive: metaInfo?['progressive'] as String?,
    );
  }
}
