import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:habr_rss/internals/fetch_http_habr.dart';
import 'package:habr_rss/presents/screens/read_screen.dart';

class HabrCardContent extends StatelessWidget {
  const HabrCardContent({
    Key? key,
    required habInfo,
  })  : _habInfo = habInfo,
        super(key: key);

  final _habInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${_habInfo.title}',
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Text(DateFormat('dd:mm:yyy kk:mm')
                .format(DateTime.parse('${_habInfo.pubDate}'))),
          ],
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          '${getDescription(_habInfo.description)}',
          style: const TextStyle(
            fontSize: 12.0,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Row(
          children: [
            toReadScreenButton(context)
          ],
        )
      ],
    );
  }

  FloatingActionButton toReadScreenButton(BuildContext context) {
    return FloatingActionButton.extended(
            heroTag: null,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReadScreen(
                  urlHab: '${_habInfo.guid}',
                ),
              ),
            ),
            label: const Text('Читать далее'),
          );
  }
}
