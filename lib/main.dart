import 'package:flashcard_flutter/bloc/appscore_cubit.dart';
import 'package:flashcard_flutter/screens/TaxonomyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  runApp(const FlashCardApp());
}

class FlashCardApp extends StatelessWidget {
  const FlashCardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) {
        return ScoreCubit();
      },
      child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Taxonomy()
          ),
    );
  }
}
