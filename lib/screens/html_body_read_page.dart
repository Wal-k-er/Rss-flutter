import 'package:flutter/material.dart';

import 'package:habr_rss/domain/models/hab_model.dart';
import 'package:habr_rss/presents/widgets/read_habr/html_habr_body.dart';

class HtmlBody extends StatelessWidget {
  const HtmlBody({
    Key? key,
    required Hab habModel,
  })  : _habModel = habModel,
        super(key: key);

  final Hab _habModel;

  @override
  Widget build(BuildContext context) {
    return HtmlHabr(
      habModel: _habModel,
    );
  }
}


