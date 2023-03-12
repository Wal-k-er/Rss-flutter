import 'package:flutter/material.dart';
import 'package:habr_rss/domain/models/hab_model.dart';
import 'package:habr_rss/screens/html_body_read_page.dart';

class FullHab extends StatelessWidget {
  const FullHab({
    Key? key,
    required Hab habModel,
  })  : _habModel = habModel,
        super(key: key);

  final Hab _habModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Text(
          _habModel.title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        HtmlBody(habModel: _habModel),
      ]),
    );
  }
}
