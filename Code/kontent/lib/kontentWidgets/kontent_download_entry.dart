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
            SizedBox(
              height: 170,
              width: 240,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Text(
                      parse(utf8.decode(item.title.codeUnits))
                          .documentElement!
                          .text,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        parse(utf8.decode(item.description.codeUnits))
                            .documentElement!
                            .text,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 15,
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
