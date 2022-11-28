import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashcard_flutter/components/share_widgets/lastpage.dart';
import 'package:flashcard_flutter/components/share_widgets/nextbar.dart';
import 'package:flashcard_flutter/components/share_widgets/playaudio.dart';
import 'package:flashcard_flutter/components/share_widgets/score_dot.dart';
import 'package:flashcard_flutter/models/cardgame_model.dart';
import 'package:flashcard_flutter/utils/Globals.dart';
import 'package:flutter/material.dart';
import 'answer_the_quiz.dart';

class PuzzleGameBody extends StatefulWidget {
  const PuzzleGameBody({
    Key? key,
    required this.size,
    required this.cardData, required this.index,
  }) : super(key: key);
  final Size size;
  final List<CardModel> cardData;
  final int index;

  @override
  State<PuzzleGameBody> createState() => _PuzzleGameBodyState();
}

class _PuzzleGameBodyState extends State<PuzzleGameBody> {
  List<bool> scoreDots = [];
  bool isNext = false;
  final PageController _pageController = PageController();

  restartGame() {
    _pageController.jumpToPage(0);
    setState(() {
      scoreDots = [];
    });
  }

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
    return PageView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      itemBuilder: (context, index) {
        nextPage() {
          _pageController.animateToPage(_pageController.page!.toInt() + 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
        }

        if (index == widget.cardData.length) {
          var trueAnswerList = scoreDots.where((element) => element == true);
          GameLastPageData data =
              GameLastPageData(trueAnswerList.length, widget.cardData.length);
          data.loadData();
          return LastPage(
              restartGame: restartGame,
              title: data.title,
              imageSrc: data.imgSrc,
              description: data.description);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScoreDot(
                  scoreDot: scoreDots,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 6,
                            blurRadius: 10,
                            offset: const Offset(
                                5, 3), // changes position of shadow
                          ),
                        ],
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
                                child: CachedNetworkImage(
                                  imageUrl: widget.cardData[index].imageUrl!,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )),
                            Positioned(
                                bottom: -15,
                                left: 0,
                                right: 0,
                                child: Center(
                                    child: AnimatedPlayAudio(
                                        url: widget.cardData[index].mediaUrl!)))
                          ],
                        ),
                        PlayQuiz(
                          trueAnswer: widget.cardData[index].name!,
                          checkResult: checkResult,
                          nextQuestions: runNextQuestion,
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          // opacity: isNext ? 1.0 : 0.0,
                          opacity: 1.0,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: NextBar(
                                  size: widget.size,
                                  isNext: isNext,
                                  nextPage: nextPage,
                                  stopNextQuestion: stopNextQuestion)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
      itemCount: widget.cardData.length + 1,
    );
  }
}
