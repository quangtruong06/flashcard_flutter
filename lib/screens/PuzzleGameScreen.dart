import 'package:flashcard_flutter/components/puzzlegame/puzzle_game_main.dart';
import 'package:flashcard_flutter/components/share_widgets/share_appbar.dart';
import 'package:flashcard_flutter/models/cardgame_model.dart';
import 'package:flutter/material.dart';

class PuzzleGame extends StatelessWidget {
  final String cardType;
  final List<CardModel> cardData;

  const PuzzleGame({Key? key, required this.cardType, required this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: ShareAppBar(
          title: cardType,
        ),
        body: PuzzleGameBody(size: size, cardData: cardData));
  }
}