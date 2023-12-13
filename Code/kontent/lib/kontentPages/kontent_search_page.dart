import 'package:flutter/material.dart';
import 'package:kontent/examples/examples.dart';
import 'package:standard_searchbar/old/standard_searchbar.dart';

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
            child: StandardSearchBar(
              onChanged: (p0) => null,
              onSubmitted: (p0) => null,
              borderRadius: 0,
              startIconSize: 35,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: Examples.exampleGenresList
                .map((e) => ListTitleEntry(data: e))
                .toList(),
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

  // onTap
}
