import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/item_model.dart';

final _root = 'hacker-news.firebaseio.com';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get(Uri.https(_root, "/v0/topstories.json"));
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get(Uri.https(_root, "/v0/item/$id.json"));
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
