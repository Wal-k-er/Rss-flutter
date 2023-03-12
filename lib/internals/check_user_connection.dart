import 'dart:io';

bool activeConnection = false;
Future checkUserConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        activeConnection = true;
    }
  } on SocketException catch (_) {
      activeConnection = false;
  }
}