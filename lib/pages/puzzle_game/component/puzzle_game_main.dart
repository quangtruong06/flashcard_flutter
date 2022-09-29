import 'package:flashcard_flutter/pages/cardgame_page/model/cardgame_model.dart';
import 'package:flashcard_flutter/widget/nextbar.dart';
import 'package:flashcard_flutter/widget/playaudio.dart';
import 'package:flutter/material.dart';
import '../../../widget/score_dot.dart';
import 'answer_the_quiz.dart';

class PuzzleGameBody extends StatefulWidget {
  const PuzzleGameBody({
    Key? key,
    required this.size,
    required this.cardData,
  }) : super(key: key);
  final Size size;
  final List<CardModel> cardData;

  @override
  State<PuzzleGameBody> createState() => _PuzzleGameBodyState();
}

class _PuzzleGameBodyState extends State<PuzzleGameBody> {
  List<bool> scoreDots = [];
  bool isNext = false;
  final PageController _pageController = PageController();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScoreDot(
            scoreDot: scoreDots,
          ),
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) {
                nextPage() {
                  _pageController.animateToPage(
                      _pageController.page!.toInt() + 1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                }
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black26)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            height: widget.size.height / 2 - 70,
                            child: Image.network(
                              widget.cardData[index].imageUrl!,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                              bottom: -15,
                              left: 0,
                              right: 0,
                              child: Center(
                                  child: PlayAudio(
                                      url: widget.cardData[index].mediaUrl!)))
                        ],
                      ),
                      PlayQuiz(
                        trueAnswer: widget.cardData[index].name!, checkResult: checkResult, nextQuestions: runNextQuestion,
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: NextBar(size: widget.size, isNext: isNext, nextPage: nextPage, stopNextQuestion: stopNextQuestion))
                    ],
                  ),
                );
              },
              itemCount: widget.cardData.length,
            ),
          ),
        ],
      ),
    );
  }
}
