import 'dart:convert';
import 'package:flashcard_flutter/models/cardgame_model.dart';
import 'package:flashcard_flutter/utils/Globals.dart';
import 'package:http/http.dart' as http;

import '../models/TaxonomyModel.dart';
Future<List<TaxonomyModel>> getTaxonomiesFromApi() async {
  var respone = await http.get(Uri.parse("https://bookingmaster.site/json/taxonomies.json"));
  if (respone.statusCode == 200) {
    List data = jsonDecode(respone.body);
    var rs = data.map((json) => TaxonomyModel.fromJson(json)).toList();
    return rs;
  }
  throw Exception("Data not found");
}

Future<List<CardModel>> getCardDataFromAPI(int id) async {
  var api = "https://bookingmaster.site/json/$id.json";
  var respone = await http.get(Uri.parse(api));
  if (respone.statusCode == 200) {
    var data = json.decode(respone.body);
    var rs = (data["flashCards"] as List)
        .map((json) => CardModel.fromJson(json))
        .toList();
    return rs;
  }
  throw Exception("Data not found");
}
// Future<List<TaxonomyModel>> getTaxonomiesFromApi() async {
//   var respone = await http.get(Uri.parse(API_TAXONOMIES));
//   print(respone.statusCode);
//   if (respone.statusCode == 200) {
//     List data = jsonDecode(respone.body);
//     var rs = data.map((json) => TaxonomyModel.fromJson(json)).toList();
//     return rs;
//   } else {
//     respone = await http.get(Uri.parse("https://bookingmaster.site/json/taxonomies.json"));
//     if (respone.statusCode == 200) {
//       List data = jsonDecode(respone.body);
//       var rs = data.map((json) => TaxonomyModel.fromJson(json)).toList();
//       return rs;
//     }
//     throw Exception("Data not found");
//   }
// }
//
// Future<List<CardModel>> getCardDataFromAPI(int id) async {
//   var respone = await http.get(Uri.parse("$API_CARDDATA$id"));
//   if (respone.statusCode == 200) {
//     var data = json.decode(respone.body);
//     var rs = (data["flashCards"] as List)
//         .map((json) => CardModel.fromJson(json))
//         .toList();
//     return rs;
//   } else {
//     var api = "https://bookingmaster.site/json/$id.json";
//     respone = await http.get(Uri.parse(api));
//     if (respone.statusCode == 200) {
//       var data = json.decode(respone.body);
//       var rs = (data["flashCards"] as List)
//           .map((json) => CardModel.fromJson(json))
//           .toList();
//       return rs;
//     }
//     throw Exception("Data not found");
//   }
// }
