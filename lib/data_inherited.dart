import 'package:flutter/material.dart';

class AppScoreDataInherited extends InheritedWidget{
  final dynamic appScoreData;
  final void Function(double) setWordGameScore;
  final void Function(double) setPuzzleGameScore;
  const AppScoreDataInherited({super.key,required this.setWordGameScore, required this.setPuzzleGameScore,  required Widget child,required this.appScoreData}):super(child: child);
  @override
  bool updateShouldNotify(covariant AppScoreDataInherited oldWidget) {
    return true;
  }
<<<<<<< HEAD
  static AppScoreDataInherited of(BuildContext context){
    final AppScoreDataInherited? result = context.dependOnInheritedWidgetOfExactType<AppScoreDataInherited>();

    return result!;
=======
  static AppScoreData of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<AppScoreData>()!;
>>>>>>> 552ff6f433c8c501dce9f04921dff87731af7851
  }
}
class AppScoreData extends StatefulWidget {
  final Size size;
  final Widget child;
  const AppScoreData({Key? key, required this.child, required this.size}) : super(key: key);

  @override
  State<AppScoreData> createState() => _AppScoreDataState();
}

class _AppScoreDataState extends State<AppScoreData> {
  final dynamic appScoreData = {"WordGame":0.0,"PuzzleGame":0.0};
  void setWordGameScore(double wordGameScore){
    setState(() {
      appScoreData["WordGame"]= wordGameScore;
    });
  }
  void setPuzzleGameScore(double puzzleGameScore){
    setState(() {
      appScoreData["PuzzleGame"]= puzzleGameScore;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return AppScoreDataInherited(setWordGameScore: setWordGameScore, setPuzzleGameScore: setPuzzleGameScore, appScoreData: appScoreData,
            child: widget.child);
      },
    );
  }
}
