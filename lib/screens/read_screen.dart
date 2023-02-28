import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habr_rss/all/html_body.dart';
import 'package:habr_rss/domain/models/hab_model.dart';
import 'package:html/parser.dart';

import 'package:habr_rss/all/fetch_http_habr.dart';

class ReadScreen extends StatefulWidget {
  final urlHab;

  ReadScreen({@required this.urlHab});

  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  final _habModel = Hab(title: '', hab_url: '', body: '');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title:  const Text('Habr RSS'),
            ),
            body: _getHab()
        )
    );
  }

  _getHab() {
    return FutureBuilder(
      future: _getHttpHab(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {

          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children:[
                Text(
                  _habModel.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold
                  ),
                ),
                HtmlBody(habModel: _habModel),
              ]
            ),
          );
        }
      },
    );
  }

  _getHttpHab() async {
    var response = await fetchHttpHabs(widget.urlHab);
    var hab = parse(response.body);
    _habModel.title = hab
        .getElementsByClassName('tm-article-snippet__title_h1')[0]
        .children[0]
        .text;
    var habs =
        hab.getElementsByClassName('article-formatted-body')[0].innerHtml;
    _habModel.body = habs.toString();
    _habModel.hab_url = widget.urlHab;
    return _habModel;
  }
}


