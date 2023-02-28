import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habr_rss/all/habr_list.dart';
import 'package:habr_rss/all/value_notifiers.dart';
import 'package:habr_rss/constants/enums/categories.dart';
import 'package:habr_rss/constants/environment_config.dart';
import 'package:habr_rss/domain/models/theme_change_notifier.dart';
import 'package:habr_rss/presents/widgets/theme_icon.dart';
import 'package:habr_rss/presents/widgets/theme_switch_widget.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:habr_rss/all/fetch_http_habr.dart';

class HomeRssPage extends StatefulWidget {
  const HomeRssPage({super.key});

  @override
  _HomeRssPageState createState() {
    return _HomeRssPageState();
  }
}

class _HomeRssPageState extends State {
  // bool _darkTheme = false;
  final List _habsList = [];

  @override
  void initState() {
    super.initState();
    // _setTheme();
  }

  _setTheme() async {
    final _prefs = context.read<SharedPreferences>();

    // setState(() {
    //   if (_prefs.getBool('darkTheme') != null) {
    //     _darkTheme = _prefs.getBool('darkTheme')!;
    //   } else {
    //     _darkTheme = false;
    //   }
    // });
  }

  String dropdownurl = Categories.all.url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Habr RSS'),
          actions: [
            buildDropdownButton(),
            ThemeIcon(),
            ThemeSwitchWidget(),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: UrlState,
          builder: (context, String url, child) {
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
        ));
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton(
      items: List.generate(
        Categories.values.length,
        (index) => DropdownMenuItem(
          value: Categories.values[index].url,
          child: Text(Categories.values[index].title),
        ),
      ),
      value: dropdownurl,
      onChanged: (String? newValue) {
        setState(() {
          dropdownurl = newValue!;
          UrlState.value = EnvironmentConfig.baseUrl + dropdownurl;
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

  _getHttpHabs(value) async {
    if (_habsList.isNotEmpty) _habsList.clear();
    var responce = await fetchHttpHabs(value);
    var chanel = RssFeed.parse(responce.body);
    for (var element in chanel.items!) {
      _habsList.add(element);
    }
    return _habsList;
  }
}


