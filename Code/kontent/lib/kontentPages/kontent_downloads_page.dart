import 'package:flutter/material.dart';
import 'package:kontent/kontentWidgets/kontent_download_entry.dart';

class KontentDownloadPageBodyWidget extends StatelessWidget {
  const KontentDownloadPageBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            KontentDownloadEntry(),
            KontentDownloadEntry(),
            KontentDownloadEntry(),
            KontentDownloadEntry(),
            KontentDownloadEntry(),
            KontentDownloadEntry(),
          ],
        ),
      ),
    );
  }
}
