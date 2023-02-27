

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:habr_rss/models/hab_model.dart';

class HtmlBody extends StatelessWidget {
  const HtmlBody({
    Key? key,
    required Hab habModel,
  }) : _habModel = habModel, super(key: key);

  final Hab _habModel;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: _habModel.body,
      customRender: {
        'flutter': ( context,  child){
          return FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            textColor: Colors.blue,
            size: context.style.fontSize!.size! * 5,
          );
        }
      },
      style: {
        'html': Style(
          color: Colors.grey,
          fontSize: FontSize.large,
        ),
        'p': Style(
            padding: const EdgeInsets.only(bottom: 10)
        ),
        'table': Style(
            backgroundColor: Colors.grey.shade200
        ),
        'tr': Style(
            backgroundColor: Colors.grey.shade400
        ),
        'code': Style(
            border: Border.all(
              width: 1,
              style: BorderStyle.solid,
            ),
            whiteSpace: WhiteSpace.NORMAL,
            padding: const EdgeInsets.all(2)
        ),
        'pre': Style(
            border: Border.all(
                color: Colors.grey,
                width: 1,
                style: BorderStyle.solid
            ),
            padding: const EdgeInsets.all(2)
        ),
        'img': Style(
            width: 700
        ),
        'a': Style (
            textDecoration: TextDecoration.none,
            color: Colors.grey,
        )
      },
    );
  }
}