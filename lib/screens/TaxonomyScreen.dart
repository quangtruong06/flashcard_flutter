import 'package:flashcard_flutter/components/taxonomy/taxonomy_appbar.dart';
import 'package:flashcard_flutter/components/taxonomy/taxonomy_drawer.dart';
import 'package:flashcard_flutter/components/taxonomy/taxonomy_main.dart';
import 'package:flashcard_flutter/data_inherited.dart';
import 'package:flutter/material.dart';

class Taxonomy extends StatelessWidget {
  const Taxonomy({Key? key}) : super(key: key);

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
