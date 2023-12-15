import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class KontentSeriesDetailPageBodyWidget extends StatelessWidget {
  const KontentSeriesDetailPageBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Placeholder(
                fallbackHeight: 200,
              ),
            ), // thumbnail photo can be used to launch the video for movies
            seriesDetailScreenTextElement("content.title", 30),
            seriesDetailScreenTextElement(
                "content.description 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'",
                15),
            seriesDetailScreenTextElement("Genre: content.genre", 15),
            seriesDetailScreenTextElement("Director: content.director", 15),
            seriesDetailScreenTextElement(
                "Age classification: content.ageClassification", 15),
            seriesDetailScreenTextElement("Genre: content.genreContent", 15),
            seriesDetailScreenTextElement("Language: content.language", 15),
            seriesDetailScreenTextElement("Rating: content.rating", 15),
            seriesDetailScreenTextElement("Review: content.review", 15),
            seriesDetailScreenTextElement("Rate: content.rate", 15),
            const Text("My rate: ", style: TextStyle(fontSize: 15)),
            RatingBar.builder(
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Write your review here',
              ),
              maxLength: 500,
            ),
            seriesDetailScreenTextElement("List of episodes: ", 25),
            seriesEpisodes(1),
            seriesEpisodes(2),
            seriesEpisodes(3),
            seriesEpisodes(4),
            seriesEpisodes(5),
          ],
        ),
      ),
    );
  }

  Padding seriesDetailScreenTextElement(String content, double textSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(content,
          style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w400)),
    );
  }

  Padding seriesEpisodes(int contentId) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Placeholder(fallbackHeight: 200),
          const SizedBox(height: 3),
          Text("Episode $contentId content.title"),
        ],
      ),
    );
  }
}
