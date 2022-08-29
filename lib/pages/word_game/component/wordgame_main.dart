// ignore_for_file: void_checks

import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flashcard_flutter/pages/cardgame_page/model/cardgame_model.dart';
import 'package:flashcard_flutter/pages/word_game/component/choose_answer.dart';
import 'package:flashcard_flutter/widget/nextbar.dart';
import 'package:flashcard_flutter/widget/playaudio.dart';
import 'package:flutter/material.dart';

class WordGameBody extends StatefulWidget {
  final Size size;
  final List<CardModel> cardData;

  const WordGameBody({Key? key, required this.size, required this.cardData})
      : super(key: key);

  @override
  State<WordGameBody> createState() => _WordGameBodyState();
}

class _WordGameBodyState extends State<WordGameBody> {
  final PageController _pageController = PageController();
  bool isNext = false;
  nextQuestion() {
    setState(() {
      isNext = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                nextPage() {
                  _pageController.animateToPage(
                      _pageController.page!.toInt() + 1,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                }
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black26)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                              child: PlayAudio(
                                  url: widget.cardData[index].mediaUrl!)),
                          Positioned.fill(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Utils.customText(
                                      text: widget.cardData[index].name,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      size: 20.0)))
                        ],
                      ),
                      const SizedBox(height: 50),
                      ChooseTheAnswer(
                        cardData: widget.cardData,
                        trueSelect: widget.cardData[index].imageUrl!,
                        size: widget.size,
                        nextQuestions: nextQuestion,
                      ),
                      const Spacer(),
                      NextBar(size: widget.size, isNext: isNext, nextQuestion: nextPage,)
                    ],
                  ),
                );
              },
              itemCount: widget.cardData.length,
            ),
          )
        ],
      ),
    );
  }
}
