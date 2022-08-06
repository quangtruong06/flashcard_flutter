import 'package:flashcard_flutter/pages/taxonomy_page/components/taxonomy_appbar.dart';
import 'package:flashcard_flutter/pages/taxonomy_page/components/taxonomy_drawer.dart';
import 'package:flashcard_flutter/pages/taxonomy_page/components/taxonomy_main.dart';
import 'package:flutter/material.dart';

class Taxonomy extends StatelessWidget {
  const Taxonomy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const TaxonomyPageAppBar(),
      drawer: TaxonomyPageDrawer(
        size: size,
      ),
      body: TaxonomyBody(
        size: size,
      ),
    );
  }
}
