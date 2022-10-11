import 'package:flashcard_flutter/components/taxonomy/taxonomy_appbar.dart';
import 'package:flashcard_flutter/components/taxonomy/taxonomy_drawer.dart';
import 'package:flashcard_flutter/components/taxonomy/taxonomy_main.dart';
import 'package:flutter/material.dart';

class Taxonomy extends StatelessWidget {
  const Taxonomy({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const TaxonomyAppBar(),
        drawer: TaxonomyDrawer(
          size: size,
        ),
        body: TaxonomyBody(
          size: size,
        ));
  }
}
