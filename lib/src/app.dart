import 'package:flutter/material.dart';
import 'package:tech_news_app/src/screens/news_list.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tech News",
      home: NewsList(),
    );
  }
}
