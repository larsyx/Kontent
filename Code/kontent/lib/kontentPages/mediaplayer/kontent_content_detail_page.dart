import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kontent/entities/content.dart';
import 'package:kontent/kontentPages/mediaplayer/kontent_video_player.dart';
import 'package:html/parser.dart';
import 'dart:convert';

import 'package:kontent/kontentWidgets/kontent_button.dart';

class KontentContentDetailPageBodyWidget extends StatelessWidget {
  var _review;
  final Content content;

  KontentContentDetailPageBodyWidget({
    super.key,
    required this.content,
  });

  Padding contentDetailScreenTextElement(String content, double textSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        content,
        style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w400),
      ),
    );
  }

  Padding seriesEpisode(Content content, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InkWell(
              child: const Placeholder(fallbackHeight: 200),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            KontentVideoPlayer(videoUrl: content.dash)),
                  )),
          const SizedBox(height: 3),
          Text(content.title),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("kontent"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
      ),
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? _buildPortraitLayout(context)
          : _buildLandscapeLayout(context),
    );
  }

  Widget _buildPortraitLayout(context) {
    return FutureBuilder(
      future: content.getRatingsAverageAndMyRatingFromirebase(),
      builder: (context, snapshot) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return InkWell(
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxWidth * 9 / 16,
                      child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/images/placeholder.jpg'),
                        image: NetworkImage(content.thumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              KontentVideoPlayer(videoUrl: content.dash)),
                    ),
                  );
                },
              ),
            ),
            contentDetailScreenTextElement(content.getTitle, 30),
            contentDetailScreenTextElement(content.getDescription, 15),
            contentDetailScreenTextElement("Genere: ${content.genre}", 15),
            contentDetailScreenTextElement(
                "Durata: ${content.duration} min", 15),
            contentDetailScreenTextElement("Regia: ${content.director}", 15),
            contentDetailScreenTextElement("Rating: ${snapshot.data?.$1}", 15),
            // contentDetailScreenTextElement(
            //     "Review: \n${snapshot.data?.$3 ?? 'Non hai ancora pubblicato una recensione per questo contenuto'}",
            //     15),
            const Text("My rate: ", style: TextStyle(fontSize: 15)),
            RatingBar.builder(
              initialRating: snapshot.data?.$2 ?? 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                content.setRatingToFirebase(rating);
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (review) => _review = review,
                    decoration: InputDecoration(
                      hintText:
                          snapshot.data?.$3 ?? 'Scrivi qui la tua recensione',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => content.setReviewToFirebase(_review),
                  child: const Text('Salva'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        contentDetailScreenTextElement(content.description, 15),
                        contentDetailScreenTextElement(
                            "Genre: ${content.genre}", 15),
                        contentDetailScreenTextElement(
                            "Duration: ${content.duration}", 15),
                        contentDetailScreenTextElement(
                            "Director: content.director", 15),
                        contentDetailScreenTextElement(
                            "Language: content.language", 15),
                        contentDetailScreenTextElement(
                            "Rating: content.rating", 15),
                        contentDetailScreenTextElement(
                            "Review: content.review", 15),
                        contentDetailScreenTextElement(
                            "Rate: content.rate", 15),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return InkWell(
                            child: SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxWidth * 9 / 16,
                              child: FadeInImage(
                                placeholder: const AssetImage(
                                    'assets/images/placeholder.png'),
                                image: NetworkImage(content.thumbnail),
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KontentVideoPlayer(
                                      videoUrl: content.dash)),
                            ),
                          );
                        },
                      ),
                    ),
                    contentDetailScreenTextElement(content.title, 30),
                    const SizedBox(height: 50),
                    // if (isSerie)
                    //   contentDetailScreenTextElement("List of episodes:", 25),
                    // if (isSerie)
                    //   for (int i = 1; i <= 5; i++) seriesEpisode(i, context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

            // GridView.count(
            //   childAspectRatio: 2 / 1,
            //   crossAxisCount: 2,
            //   children: episodes.map((e) => seriesEpisode(e, context)).toList(),
            // )

// @override
// Widget build(BuildContext context) {
//   return SingleChildScrollView(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.0),
//             child: Placeholder(
//               fallbackHeight: 200,
//             ),
//           ), // thumbnail photo can be used to launch the video for movies
//           contentDetailScreenTextElement("content.title", 30),
//           contentDetailScreenTextElement(
//               "content.description 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'",
//               15),
//           contentDetailScreenTextElement("Genre: content.genre", 15),
//           contentDetailScreenTextElement("Director: content.director", 15),
//           contentDetailScreenTextElement(
//               "Age classification: content.ageClassification", 15),
//           contentDetailScreenTextElement("Genre: content.genreContent", 15),
//           contentDetailScreenTextElement("Language: content.language", 15),
//           contentDetailScreenTextElement("Rating: content.rating", 15),
//           contentDetailScreenTextElement("Review: content.review", 15),
//           contentDetailScreenTextElement("Rate: content.rate", 15),
//           const Text("My rate: ", style: TextStyle(fontSize: 15)),
//           RatingBar.builder(
//             minRating: 1,
//             direction: Axis.horizontal,
//             allowHalfRating: true,
//             itemCount: 5,
//             itemSize: 20,
//             itemBuilder: (context, _) => const Icon(
//               Icons.star,
//               color: Colors.amber,
//             ),
//             onRatingUpdate: (rating) {},
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'Write your review here',
//             ),
//             maxLength: 500,
//           ),
//           contentDetailScreenTextElement("List of episodes: ", 25),
//           seriesEpisodes(1),
//           seriesEpisodes(2),
//           seriesEpisodes(3),
//           seriesEpisodes(4),
//           seriesEpisodes(5),
//         ],
//       ),
//     ),
//   );
