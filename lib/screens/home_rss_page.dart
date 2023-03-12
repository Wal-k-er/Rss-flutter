import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

import 'package:habr_rss/presents/widgets/habrs_list/habr_list.dart';
import 'package:habr_rss/domain/notifiers/value_notifiers.dart';
import 'package:habr_rss/constants/enums/categories.dart';
import 'package:habr_rss/constants/environment_config.dart';
import 'package:habr_rss/presents/widgets/theme/theme_icon.dart';
import 'package:habr_rss/internals/check_user_connection.dart';
import 'package:habr_rss/presents/widgets/theme/theme_switch_widget.dart';
import 'package:habr_rss/internals/fetch_http_habr.dart';

class HomeRssPage extends StatefulWidget {
  const HomeRssPage({super.key});

  @override
  _HomeRssPageState createState() {
    return _HomeRssPageState();
  }
}

class _HomeRssPageState extends State {
  @override
  void initState() {
    checkUserConnection();
    super.initState();
  }

  final List _habsList = [];

  var dropdownurl = Categories.all.url;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Habr RSS'),
          actions: [
            buildDropdownButton(),
            const ThemeIcon(),
            ThemeSwitchWidget(),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: UrlState,
          builder: (context, String url, child) {
            return FutureBuilder(
              future: _getHttpHabs(url),
              builder: (context, AsyncSnapshot snapshot) {
                checkUserConnection();
                if (activeConnection) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return HabrList(habsList: _habsList);
                  }
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Проверьте интернет-соединение',
                      ),
                      Image.asset(
                        "assets/png/lost-connect.png",
                      )
                    ],
                  ));
                }
              },
            );
          },
        ),
      ),
    );
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
        checkUserConnection();
        setState(() {
          dropdownurl = newValue!;
          UrlState.value = EnvironmentConfig.baseUrl + dropdownurl;
        });
      },
      iconEnabledColor: Colors.white,
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(10.0),
        right: Radius.circular(10.0),
      ),
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
