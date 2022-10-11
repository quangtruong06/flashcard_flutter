import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
Future<void> setGameScore(Map yourScore) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString("gamescore")==null){
    prefs.setString("gamescore", jsonEncode(yourScore));
  }else{
    var jsondata = prefs.getString("gamescore")!;
    return json.decode(jsondata);
  }
  print(prefs.getString("gamescore"));
}