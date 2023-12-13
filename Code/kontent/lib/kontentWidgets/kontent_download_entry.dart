import 'package:flutter/material.dart';
import 'package:kontent/entities/item.dart';

class KontentDownloadEntry extends StatelessWidget {
  final Item item;

  const KontentDownloadEntry({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            height: 170,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: const BoxDecoration(color: Colors.black),
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
                    item.titolo,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      item.descrizione,
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
    );
  }
}
