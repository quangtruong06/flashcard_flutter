import 'package:flashcard_flutter/save/shared_prefence.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppScoreDataInherited extends InheritedWidget {
  final dynamic appScore;
  final void Function(double) setWordGameScore;
  final void Function(double) setPuzzleGameScore;

  const AppScoreDataInherited(
      {super.key,
      required this.setWordGameScore,
      required this.setPuzzleGameScore,
      required Widget child,
      required this.appScore})
      : super(child: child);

  @override
  bool updateShouldNotify(AppScoreDataInherited oldWidget) {
    return appScore != oldWidget.appScore;
  }

  static AppScoreDataInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppScoreDataInherited>()!;
  }
}

class AppScoreData extends StatefulWidget {
  final Widget child;

  const AppScoreData({Key? key, required this.child}) : super(key: key);

  @override
  State<AppScoreData> createState() => _AppScoreDataState();
}

class _AppScoreDataState extends State<AppScoreData> {
  dynamic appScoreData = {"WordGame": 0.0, "PuzzleGame": 0.0};
  final prefs = SharedPreferences.getInstance();

  void setWordGameScore(double wordGameScore) {
    setState(() {
      appScoreData["WordGame"] = wordGameScore;
    });
  }

  void setPuzzleGameScore(double puzzleGameScore) {
    setState(() {
      appScoreData["PuzzleGame"] = puzzleGameScore;
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScoreDataInherited(
        setWordGameScore: setWordGameScore,
        setPuzzleGameScore: setPuzzleGameScore,
        appScore: appScoreData,
        child: widget.child);
  }
}
