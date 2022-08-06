import 'package:flashcard_flutter/pages/cardgame_page/component/cardgame_appbar.dart';
import 'package:flashcard_flutter/pages/cardgame_page/component/cardgame_main.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_flutter/pages/taxonomy_page/model/taxonomy_model.dart';

class CardGamePage extends StatelessWidget {
  final TaxonomyModel data;

  const CardGamePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CardGameAppBar(title: data.name),
      body: CardGameBody(data: data,),
    );
  }
}
