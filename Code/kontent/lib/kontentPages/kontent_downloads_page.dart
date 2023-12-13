import 'package:flutter/material.dart';
import 'package:kontent/entities/item.dart';
import 'package:kontent/kontentWidgets/kontent_download_entry.dart';

class KontentDownloadPageBodyWidget extends StatelessWidget {
  final List<Item> itemList;

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
                    item: Item(
                      id: e.id,
                      titolo: e.titolo,
                      descrizione: e.descrizione,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
