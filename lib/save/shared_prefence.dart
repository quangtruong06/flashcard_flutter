import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
Future<dynamic> setGameScore(double wordgameScore,double puzzlegameScore) async {
  final prefs = await SharedPreferences.getInstance();
  var yourScore = {
    "WordGame":wordgameScore,"PuzzleGame":puzzlegameScore
  };
  if (prefs.getString("gamescore")==null){
    prefs.setString("gamescore", jsonEncode(yourScore));
  }else{
    var jsondata = prefs.getString("gamescore")!;
    return json.decode(jsondata);
  }
}