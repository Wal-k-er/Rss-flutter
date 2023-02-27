import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

fetchHttpHabs(url) {
  var client = http.Client();
  print('object'+url);
  return client.get(Uri.parse(url));
}

var nextList = [
  'Читать далее',
  'Читать дальше',
  'Узнать больше',
];
getDescription(description) {
  description = parse(description);

  var textDescription = parse(description.body.text).documentElement!.text;
  for(var next in nextList){
    if (textDescription.contains(next)) {
      textDescription =
          textDescription.substring(0, textDescription.indexOf(next));
    }
  }
  return textDescription;
}
