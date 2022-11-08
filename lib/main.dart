import 'package:flashcard_flutter/bloc/appscore_cubit.dart';
import 'package:flashcard_flutter/bloc/taxonomy_bloc/taxonomy_bloc.dart';
import 'package:flashcard_flutter/bloc/taxonomy_bloc/taxonomy_event.dart';
import 'package:flashcard_flutter/screens/TaxonomyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const FlashCardApp());
}

class FlashCardApp extends StatelessWidget {
  const FlashCardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ScoreCubit>(
        create: (BuildContext context) => ScoreCubit(),
      ),
      BlocProvider<TaxonomyBloc>(
        create: (BuildContext context) => TaxonomyBloc(httpClient: http.Client())..add(TaxonomyFetched()),
      ),
    ], child: const MaterialApp(
        debugShowCheckedModeBanner: false, home: Taxonomy()));
  }
}
