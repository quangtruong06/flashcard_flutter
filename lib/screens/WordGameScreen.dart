import 'package:flashcard_flutter/components/share_widgets/share_appbar.dart';
import 'package:flashcard_flutter/components/wordgame/wordgame_main.dart';
import 'package:flashcard_flutter/models/cardgame_model.dart';
import 'package:flutter/material.dart';

class WordGame extends StatelessWidget {
  final int index;
  final String cardType;
  final List<CardModel> cardData;
  const WordGame({Key? key, required this.cardType, required this.cardData, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ShareAppBar(
        title: cardType,
      ),
      body: WordGameBody(
        size: size,
        cardData: cardData, index: index,
      ),
    );
  }
}
