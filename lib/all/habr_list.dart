import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:habr_rss/all/fetch_http_habr.dart';
import 'package:habr_rss/screens/read_screen.dart';

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
            child: Column(
              children: [
                Text(
                  '${_habsList[index].title}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(DateFormat('dd:mm:yyy kk:mm')
                        .format(
                        DateTime.parse('${_habsList[index].pubDate}'))
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  '${getDescription(_habsList[index].description)}',
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReadScreen(
                                    urlHab: '${_habsList[index].guid}',
                                  ))),
                      label: const Text('Читать далее'),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
