import 'package:flutter/material.dart';
import 'package:habr_rss/screens/home_screen.dart';


void main() {

  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenRss();
  }

}


