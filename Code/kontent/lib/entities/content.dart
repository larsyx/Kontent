import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:html/parser.dart';
import 'package:quiver/core.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

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

  get getTitle => parse(utf8.decode(title.codeUnits)).documentElement!.text;

  get getDescription =>
      parse(utf8.decode(description.codeUnits)).documentElement!.text;

  get getThumbnail => thumbnail;

  get getDash => dash;

  get getGenre => genre;

  get getDuration => duration;

  get getDirector => director;

  Future<(double, double, String?)>
      getRatingsAverageAndMyRatingFromirebase() async {
    double ratingsAverage = await getRatingAverageFromFirebase();
    double myRating = await getMyRatingFromFirebase();
    String? myReview = await getMyReviewFromFirebase();
    return (ratingsAverage, myRating, myReview);
  }

  Future<double> getRatingAverageFromFirebase() async {
    return await db.collection("items").doc(getTitle).get().then((value) {
      final Map<String, dynamic>? resultMap = value.data()?["ratings"];
      final double? sum =
          resultMap?.values.reduce((value, element) => value + element);
      return resultMap != null ? (sum! / resultMap.length) : 0;
    });
  }

  Future<double> getMyRatingFromFirebase() async {
    final User? user = auth.currentUser;
    return await db.collection("items").doc(getTitle).get().then((value) {
      final double? myRating = value.data()?['ratings']?['${user?.email}'];
      return myRating ?? 0;
    });
  }

  void setRatingToFirebase(double rating) {
    final User? user = auth.currentUser;
    db.collection("items").doc(getTitle).set({
      "ratings": {"${user!.email}": rating}
    }, SetOptions(merge: true)).onError(
        (e, _) => print("Error writing document: $e"));
  }

  Future<String?> getMyReviewFromFirebase() async {
    final User? user = auth.currentUser;
    return await db.collection("items").doc(getTitle).get().then((value) {
      final String? myReview = value.data()?['reviews']?['${user?.email}'];
      return myReview;
    });
  }

  void setReviewToFirebase(String review) {
    if (review.trim() == '') return;
    final User? user = auth.currentUser;
    db.collection("items").doc(getTitle).set({
      "reviews": {"${user!.email}": review}
    }, SetOptions(merge: true)).onError(
        (e, _) => print("Error writing document: $e"));
  }

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
