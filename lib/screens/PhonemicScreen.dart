import 'package:flashcard_flutter/components/phonemic/phonemic_game_appbar.dart';
import 'package:flashcard_flutter/components/phonemic/phonemic_game_main.dart';
import 'package:flashcard_flutter/models/cardgame_model.dart';
import 'package:flutter/material.dart';

class PhonemicGame extends StatelessWidget {
  final String cardType;
  final List<CardModel> cardData;
  const PhonemicGame({Key? key, required this.cardType, required this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PhonemicGameAppBar(
        cardType: cardType,
      ),
      body: PhonemicGameBody(
        cardData: cardData,
        size: size,
      ),
    );
  }
}
