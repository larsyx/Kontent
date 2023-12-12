import 'package:flutter/material.dart';

class KontentSearchPageBodyWidget extends StatelessWidget {
  const KontentSearchPageBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                shape: const MaterialStatePropertyAll(LinearBorder()),
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
              );
            }, suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    // setState(() {
                    //   controller.closeView(item);
                    // });
                  },
                );
              });
            }),
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: const <Widget>[
              ListTitleEntry(data: 'Commedia'),
              ListTitleEntry(data: 'Thriller'),
              ListTitleEntry(data: 'Horror'),
              ListTitleEntry(data: 'Azione'),
              ListTitleEntry(data: 'Fantasy'),
            ],
          )
        ],
      ),
    );
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
      title: Text(data),
      trailing: const Icon(Icons.arrow_forward),
      shape: const Border(
        bottom: BorderSide(),
      ),
    );
  }
}
