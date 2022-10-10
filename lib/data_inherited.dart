import 'package:flutter/material.dart';

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
    return true;
  }
  static AppScoreDataInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppScoreDataInherited>()!;
  }
}

class AppScoreData extends StatefulWidget {
  final Size size;
  final Widget child;
  const AppScoreData({Key? key, required this.child, required this.size})
      : super(key: key);

  @override
  State<AppScoreData> createState() => _AppScoreDataState();
}
class _AppScoreDataState extends State<AppScoreData> {
  final dynamic appScoreData = {"WordGame": 0.0, "PuzzleGame": 0.0};

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
  Widget build(BuildContext context) {
    return AppScoreDataInherited(
        setWordGameScore: setWordGameScore,
        setPuzzleGameScore: setPuzzleGameScore,
        appScore: appScoreData,
        child: widget.child);
  }
}
