import 'dart:math';

import 'package:flashcard_flutter/pages/cardgame_page/model/cardgame_model.dart';
import 'package:flutter/material.dart';

class ChooseTheAnswer extends StatefulWidget {
  final Size size;
  final List<CardModel> cardData;
  final String trueSelect;
  bool isNext;

  ChooseTheAnswer(
      {Key? key,
      required this.cardData,
      required this.trueSelect,
      required this.isNext,
      required this.size})
      : super(key: key);

  @override
  State<ChooseTheAnswer> createState() => _ChooseTheAnswerState();
}

class _ChooseTheAnswerState extends State<ChooseTheAnswer> {
  int? tappedIndex;
  bool? yourResultIs;
  List<String> theSelect = [];
  bool isShowResult = false;

  getRandomImage() {
    theSelect = [];
    theSelect.add(widget.trueSelect);
    List<CardModel> list = widget.cardData;
    final random = Random();
    while (theSelect.toList().length < 4) {
      var randomImageUrl = list[random.nextInt(list.length)].imageUrl;
      var b = theSelect.toSet().toList();
      b.add(randomImageUrl!);
      theSelect = b.toSet().toList();
    }
    // print(object)
    theSelect.shuffle();
  }

  void checkYourResult(int tappedIndex) {
    if (theSelect[tappedIndex] == widget.trueSelect) {
      yourResultIs = true;
    } else {
      yourResultIs = false;
    }
  }

  double showYourResult(int yourSelect) {
    if (theSelect[yourSelect] == widget.trueSelect) {
      return isShowResult ? 1.0 : 0.0;
    } else {
      return (tappedIndex == yourSelect)
          ? isShowResult
              ? 1.0
              : 0.0
          : 0.0;
    }
  }

  Widget resultIcon(int yourSelect) {
    if (theSelect[yourSelect] == widget.trueSelect) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration:
            const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration:
            const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      );
    }
  }

  @override
  void initState() {
    getRandomImage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height / 2,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  tappedIndex = index;
                  isShowResult = true;
                  checkYourResult(tappedIndex!);
                  widget.isNext = true;
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            offset: const Offset(0.5, 2),
                            spreadRadius: 1,
                            blurRadius: 3)
                      ],
                      image: DecorationImage(
                          image: NetworkImage(theSelect[index]),
                          fit: BoxFit.cover),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: showYourResult(index),
                      duration: const Duration(milliseconds: 500),
                      child: resultIcon(index),
                    ),
                  )));
        },
        itemCount: theSelect.length,
      ),
    );
  }
}
