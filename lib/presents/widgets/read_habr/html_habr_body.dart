import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:habr_rss/domain/models/hab_model.dart';

class HtmlHabr extends StatelessWidget {
  const HtmlHabr({
    Key? key,
    required Hab habModel,
  })  : _habModel = habModel,
        super(key: key);

  final Hab _habModel;

  @override
  Widget build(BuildContext context) {
    ImageSourceMatcher classAndIdMatcher() => (attributes, element) =>
        attributes["class"] != null && attributes["id"] != null;

    ImageRender classAndIdRender() => (context, attributes, element) {
          return Image.network(
            attributes["src"] ?? "about:blank",
            semanticLabel: attributes["longdesc"] ?? "",
            width: double.parse(attributes["width"]!),
            height: double.parse(attributes["height"]!),
            alignment: Alignment.center,
            color: context.style.color,
            frameBuilder: (ctx, child, frame, _) {
              if (frame == null) {
                return Text(
                  attributes["alt"] ?? "",
                  style: context.style.generateTextStyle(),
                );
              }
              return child;
            },
          );
        };
    return Html(
      data: _habModel.body,
      customRender: {
        'flutter': (context, child) {
          return FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            textColor: Colors.blue,
            size: context.style.fontSize!.size! * 5,
          );
        },
      },
      customImageRenders: {classAndIdMatcher(): classAndIdRender()},
      style: {
        'html': Style(
          fontSize: FontSize.large,
          fontFamily: 'Times New Roman',
          fontWeight: FontWeight.bold,
        ),
        'p': Style(
          padding: const EdgeInsets.only(bottom: 10),
        ),
        'code': Style(
          border: Border.all(
            width: 1,
            style: BorderStyle.solid,
          ),
          whiteSpace: WhiteSpace.NORMAL,
          padding: const EdgeInsets.all(2),
        ),
        'table': Style(
          alignment: Alignment.center,
          verticalAlign: VerticalAlign.BASELINE,
        ),
        'pre': Style(
          border: Border.all(
            color: Colors.grey,
            width: 1,
            style: BorderStyle.solid,
          ),
          padding: const EdgeInsets.all(2),
        ),
        'a': Style(
          textDecoration: TextDecoration.none,
        ),
        'figure': Style(
          display: Display.BLOCK,
        )
      },
    );
  }
}
