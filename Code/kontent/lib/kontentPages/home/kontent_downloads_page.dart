import 'package:flutter/material.dart';
import 'package:kontent/entities/content.dart';
import 'package:kontent/kontentWidgets/kontent_download_entry.dart';

class KontentDownloadPageBodyWidget extends StatelessWidget {
  final List<Content> itemList;

  const KontentDownloadPageBodyWidget({super.key, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: itemList
              .map((e) => KontentDownloadEntry(
                    item: Content(
                      id: e.id,
                      title: e.title,
                      description: e.description,
                      thumbnail: '',
                      genre: '',
                      duration: 0,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
