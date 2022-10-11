import 'package:flashcard_flutter/data_inherited.dart';
import 'package:flashcard_flutter/screens/TaxonomyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const FlashCardApp());
}

class FlashCardApp extends StatelessWidget {
  const FlashCardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 1070),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return const AppScoreData(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Taxonomy(),
          )
        );
      },
    );
  }
}
