import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:kontent/entities/content.dart';
import 'package:kontent/kontentPages/mediaplayer/kontent_content_detail_page.dart';

class KontentDownloadEntry extends StatelessWidget {
  final Content item;

  const KontentDownloadEntry({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  KontentContentDetailPageBodyWidget(content: item)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100,
              height: 170,
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.thumbnail),
                  fit: BoxFit.fill,
                ),
                color: Colors.black,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Text(
                      item.getTitle,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        item.getDescription,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
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
