import 'package:flashcard_flutter/models/cardgame_model.dart';
import 'package:flutter/material.dart';

import '../../utils/Globals.dart';
import '../../utils/Utils.dart';
import '../share_widgets/lastpage.dart';
import '../share_widgets/nextbar.dart';
import '../share_widgets/playaudio.dart';
import '../share_widgets/score_dot.dart';
import 'choose_answer.dart';

class WordGameBody extends StatefulWidget {
  final Size size;
  final List<CardModel> cardData;

  const WordGameBody({Key? key, required this.size, required this.cardData})
      : super(key: key);

  @override
  State<WordGameBody> createState() => _WordGameBodyState();
}

class _WordGameBodyState extends State<WordGameBody> {
  List<bool> scoreDots = [];
  final PageController _pageController = PageController();
  bool isNext = false;
  bool? yourResultIs;

  checkResult(bool? yourResult) {
    setState(() {
      scoreDots.add(yourResult!);
    });
  }

  runNextQuestion() {
    setState(() {
      isNext = true;
    });
  }

  stopNextQuestion() {
    setState(() {
      isNext = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                }

                if (index == widget.cardData.length) {
                  var trueAnswerList =
                      scoreDots.where((element) => element == true);
                  GameLastPageData data =
                      GameLastPageData(trueAnswerList.length, scoreDots.length);
                  data.loadData();
                  return LastPage(
                      title: data.title,
                      imageSrc: data.imgSrc,
                      description: data.description);
                } else {
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
                        ScoreDot(
                          scoreDot: scoreDots,
                        ),
                        ChooseTheAnswer(
                          cardData: widget.cardData,
                          trueSelect: widget.cardData[index].imageUrl!,
                          size: widget.size,
                          nextQuestions: runNextQuestion,
                          checkResult: checkResult,
                        ),
                        const Spacer(),
                        NextBar(
                          size: widget.size,
                          isNext: isNext,
                          nextPage: nextPage,
                          stopNextQuestion: stopNextQuestion,
                        )
                      ],
                    ),
                  );
                }
              },
              itemCount: widget.cardData.length + 1,
            ),
          )
        ],
      ),
    );
  }
}
