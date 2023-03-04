import 'dart:developer';
import 'dart:io';

bool ActiveConnection = false;
String T = "";
Future CheckUserConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        log('aaaaaaaaa');
        ActiveConnection = true;

    }
  } on SocketException catch (_) {

      log('______');
      ActiveConnection = false;

  }
}