import 'package:flashcard_flutter/pages/cardgame_page/model/cardgame_model.dart';
import 'package:flashcard_flutter/pages/word_game/component/wordgame_main.dart';
import 'package:flashcard_flutter/widget/share_appbar.dart';
import 'package:flutter/material.dart';
class WordGame extends StatelessWidget {
  final String cardType;
  final List<CardModel> cardData;
  const WordGame({Key? key, required this.cardType, required this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ShareAppBar(title: cardType,
      ),
      body: WordGameBody(size: size,cardData: cardData,),
    );
  }
}
