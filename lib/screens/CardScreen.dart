
import 'package:flashcard_flutter/components/cardgames/cardgame_main.dart';
import 'package:flashcard_flutter/components/share_widgets/share_appbar.dart';
import 'package:flutter/material.dart';

import '../models/TaxonomyModel.dart';
class CardGamePage extends StatelessWidget {
  final TaxonomyModel data;

  const CardGamePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShareAppBar(title: data.name),
      body: CardGameBody(
        data: data,
      ),
    );
  }
}
