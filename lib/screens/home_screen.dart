import 'package:flutter/material.dart';
import 'package:habr_rss/all/habr_list.dart';
import 'package:habr_rss/all/value_notifiers.dart';
import 'package:webfeed/webfeed.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:habr_rss/all/fetch_http_habr.dart';

class HomeScreenRss extends StatefulWidget {
  const HomeScreenRss({super.key});

  @override
  _HomeScreenRssState createState() {
    return _HomeScreenRssState();
  }
}

class _HomeScreenRssState extends State {
  bool _darkTheme = false;
  final List _habsList = [];
  String Url = 'https://habr.com/ru/rss/all/';

  @override
  void initState() {
    super.initState();
    _setTheme();
  }

  String baseurl = 'https://habr.com/ru/rss/';

  _setTheme() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_prefs.getBool('darkTheme') != null) {
        _darkTheme = _prefs.getBool('darkTheme')!;
      } else {
        _darkTheme = false;
      }
    });
  }

  String dropdownurl = 'all/';
  var urls = {
    'all/': 'Все потоки',
    'flows/develop/': 'Разработка',
    'flows/admin/': 'Администрирование',
    'flows/design/': 'Дизайн',
    'flows/management/': 'Менеджмент',
    'flows/marketing/': 'Маркетинг',
    'flows/popsci/': 'Научпоп',
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: !_darkTheme ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Habr RSS'),
            actions: [
              buildDropdownButton(),
              Icon(_getAppBarIcon()),
              Switch(
                  value: _darkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      _darkTheme = !_darkTheme;
                      _saveTheme();
                    });
                  })
            ],
          ),
          body: ValueListenableBuilder(
            valueListenable: UrlState,
            builder: (context, String url, child) {
              print(url);
              return FutureBuilder(
                future: _getHttpHabs(url),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return HabrList(habsList: _habsList);
                  }
                },
              );
            },
          )),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton(
      items: urls
          .map((partUrl, text) {
            return MapEntry(
                text,
                DropdownMenuItem(
                  value: partUrl,
                  child: Text(text),
                ));
          })
          .values
          .toList(),
      value: dropdownurl,
      onChanged: (String? newValue) {
        setState(() {
          dropdownurl = newValue!;
          UrlState.value = baseurl + dropdownurl;
        });
      },
      iconEnabledColor: Colors.white,
      borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(10.0), right: Radius.circular(10.0)),
      dropdownColor: Colors.blue,
      isExpanded: false,
      style: const TextStyle(inherit: true),
      alignment: AlignmentDirectional.centerStart,
    );
  }

  _getAppBarIcon() {
    if (_darkTheme) {
      return Icons.lightbulb_outline;
    } else {
      return Icons.lightbulb;
    }
  }

  _getHttpHabs(value) async {
    if (_habsList.isNotEmpty) _habsList.clear();
    var responce = await fetchHttpHabs(value);
    var chanel = RssFeed.parse(responce.body);
    for (var element in chanel.items!) {
      _habsList.add(element);
    }
    return _habsList;
  }

  _saveTheme() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('darkTheme', _darkTheme);
  }
}
