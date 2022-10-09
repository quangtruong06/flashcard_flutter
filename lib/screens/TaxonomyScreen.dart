import 'package:flashcard_flutter/components/taxonomy/taxonomy_appbar.dart';
import 'package:flashcard_flutter/components/taxonomy/taxonomy_drawer.dart';
import 'package:flashcard_flutter/components/taxonomy/taxonomy_main.dart';
import 'package:flashcard_flutter/data_inherited.dart';
import 'package:flutter/material.dart';

<<<<<<< HEAD
class Taxonomy extends StatelessWidget {
  const Taxonomy({Key? key}) : super(key: key);

=======
class Taxonomy extends StatefulWidget {
  const Taxonomy({super.key});

  @override
  State<Taxonomy> createState() => _TaxonomyState();
}

class _TaxonomyState extends State<Taxonomy> {
  final dynamic appScoreData = {
    "WordGame":0.0,
    "PuzzleGame":0.0
  };
>>>>>>> 552ff6f433c8c501dce9f04921dff87731af7851
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const TaxonomyAppBar(),
        drawer: TaxonomyDrawer(
          size: size,
        ),
        body: AppScoreData(
          size: size,
          child: TaxonomyBody(
            size: size,
          ),
        ));
  }
}
