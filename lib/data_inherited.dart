import 'package:flutter/material.dart';

class AppScoreData extends InheritedWidget{
  final dynamic appScoreData;
  const AppScoreData({super.key, required Widget child,this.appScoreData}):super(child: child);
  @override
  bool updateShouldNotify(covariant AppScoreData oldWidget) {
    return appScoreData != oldWidget.appScoreData;
  }
  static AppScoreData of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<AppScoreData>()!;
  }
}