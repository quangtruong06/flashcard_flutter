import 'dart:convert';
import 'package:flashcard_flutter/models/cardgame_model.dart';
import 'package:flashcard_flutter/utils/Globals.dart';
import 'package:http/http.dart' as http;

import '../models/TaxonomyModel.dart';

Future<List<TaxonomyModel>> getTaxonomiesFromApi() async {
  final respone = await http.get(Uri.parse(API_TAXONOMIES));
  if (respone.statusCode == 200) {
    List data = jsonDecode(respone.body);
    var rs = data.map((json) => TaxonomyModel.fromJson(json)).toList();
    return rs;
  } else {
    throw Exception("Data not found");
  }
}

Future<List<CardModel>> getCardDataFromAPI(int id) async {
  final respone = await http.get(Uri.parse("$API_CARDDATA$id"));
  if (respone.statusCode == 200) {
    var data = json.decode(respone.body);
    var rs = (data["flashCards"] as List)
        .map((json) => CardModel.fromJson(json))
        .toList();
    return rs;
  } else {
    throw Exception("Data not found");
  }
}
