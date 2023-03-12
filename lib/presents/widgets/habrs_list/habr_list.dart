import 'package:flutter/material.dart';

import 'package:habr_rss/presents/widgets/habrs_list/habr_card_content.dart';

class HabrList extends StatelessWidget {
  const HabrList({
    Key? key,
    required List habsList,
  })  : _habsList = habsList,
        super(key: key);

  final List _habsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      scrollDirection: Axis.vertical,
      itemCount: _habsList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: HabrCardContent(habInfo: _habsList[index]),
          ),
        );
      },
    );
  }
}


