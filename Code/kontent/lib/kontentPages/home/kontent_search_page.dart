import 'package:flutter/material.dart';
import 'package:kontent/cms/cms_request.dart';
import 'package:kontent/entities/carousel.dart';
import 'package:kontent/entities/content.dart';
import 'package:kontent/entities/page.dart' as kontent_page;
import 'package:kontent/examples/examples.dart';
import 'package:kontent/kontentPages/home/kontent_downloads_page.dart';
import 'package:kontent/kontentWidgets/kontent_carousel.dart';
import 'package:standard_searchbar/old/standard_searchbar.dart';

List<Content> contents = [];

class KontentSearchPageBodyWidget extends StatelessWidget {
  final String idPage;

  const KontentSearchPageBodyWidget({super.key, required this.idPage});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPage(idPage),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //in attesa
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            //errore
            print(
                'Si è verificato un errore durante la richiesta: ${snapshot.error}');
            return const Center(
              child: Text('Errore durante la richiesta della pagina',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            print('Pagina inesistente');
            return const Center(
                child: Text('Pagina inesistente',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)));
          }

          kontent_page.Page page = snapshot.data!;
          for (Carousel carousel in page.getCarousels) {
            contents.addAll(carousel.items);
          }
          contents = contents.toSet().toList();

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: StandardSearchBar(
                    onChanged: (p0) => null,
                    onSubmitted: (sarchText) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KontentDownloadPageBodyWidget(
                          itemList: contents
                              .where((element) => element.title
                                  .toLowerCase()
                                  .contains(sarchText.toLowerCase()))
                              .toList(),
                        ),
                      ),
                    ),
                    borderRadius: 0,
                    startIconSize: 35,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: Examples.exampleGenresList
                      .map((e) => ListTitleEntry(data: e))
                      .toList(),
                )
              ],
            ),
          );
        });
  }
}

class ListTitleEntry extends StatelessWidget {
  final String data;

  const ListTitleEntry({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KontentDownloadPageBodyWidget(
            itemList: contents
                .where((element) =>
                    element.genre.toLowerCase() == data.toLowerCase())
                .toList(),
          ),
        ),
      ),
      title: Text(data),
      trailing: const Icon(Icons.arrow_forward),
      shape: const Border(
        bottom: BorderSide(),
      ),
    );
  }

  // onTap
}
