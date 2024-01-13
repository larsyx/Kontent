import 'package:flutter/material.dart';
import 'package:kontent/entities/content.dart';
import 'package:kontent/kontentWidgets/kontent_download_entry.dart';

class KontentDownloadPageBodyWidget extends StatelessWidget {
  final List<Content> itemList;

  const KontentDownloadPageBodyWidget({super.key, required this.itemList});

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
      body: OrientationBuilder(builder: (constext, orientation) {
        return GridView.count(
          childAspectRatio: 3 / 1,
          crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
          children: itemList.isNotEmpty
              ? itemList
                  .map((item) => KontentDownloadEntry(
                        item: Content(
                          id: item.id,
                          title: item.title,
                          description: item.description,
                          thumbnail: item.thumbnail,
                          genre: '',
                          duration: 0,
                          director: '',
                        ),
                      ))
                  .toList()
              : [
                  const Center(
                    child: Text('Nessun risultato'),
                  )
                ],
        );
      }),
    );
  }
}


// @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: itemList
//               .map((e) => KontentDownloadEntry(
//                     item: Content(
//                       id: e.id,
//                       title: e.title,
//                       description: e.description,
//                       thumbnail: '',
//                       genre: '',
//                       duration: 0,
//                     ),
//                   ))
//               .toList(),
//         ),
//       ),
//     );
//   }