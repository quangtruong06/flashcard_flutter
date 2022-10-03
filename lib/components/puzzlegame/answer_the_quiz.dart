import 'dart:math';
import 'package:flashcard_flutter/utils/Utils.dart';
import 'package:flutter/material.dart';

class PlayQuiz extends StatefulWidget {
  final String trueAnswer;
  final Function nextQuestions;
  final Function checkResult;
  const PlayQuiz({Key? key, required this.trueAnswer, required this.nextQuestions, required this.checkResult}) : super(key: key);

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}
class _PlayQuizState extends State<PlayQuiz> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool isFullAnswered = false;
  List yourAnswer = [];// kết quả
  List quizRandomAlphabet = []; //random list abc
  List listAnswer = [];
  bool isClicked = false;
  bool yourAnswerIs = false;

  checkYourAnswer() {
    String answer = "";
    for (var element in yourAnswer) {
      answer += element["answer"];
    }
    if (answer.toUpperCase() == widget.trueAnswer.trim().toUpperCase()) {
      setState(() {
        yourAnswerIs = true;
      });
    }
    else {
     setState(() {
       yourAnswerIs = false;
     });
    }
  }
  clickedAlphabet(int index) {
    setState(() {
      isClicked = true;
      quizRandomAlphabet[index] = "";
    });
  }
  getRandomAlphabet() {
    quizRandomAlphabet = [];
    final List trueAlphabet = widget.trueAnswer.trim().toUpperCase().split("");
    List list = [];
    final random = Random();
    var randomAlphabetLength = trueAlphabet.length;
    const avalableAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    List randomAlphabet = List.generate(randomAlphabetLength,
        (index) => avalableAlphabet[random.nextInt(avalableAlphabet.length)]);
    list.add(trueAlphabet);
    list.add(randomAlphabet);
    quizRandomAlphabet = list.expand((element) => element).toList();
    quizRandomAlphabet.shuffle();
  }
  fillAnswer(String chooseAlphabet, int index) {
    var unAnswer = yourAnswer.indexWhere((element) => element["answer"]=="");
    setState(() {
      yourAnswer[unAnswer]["answer"] = chooseAlphabet;
      yourAnswer[unAnswer]["index"] = index;
      isClicked = true;
    });
  }
  returnAlphabet(String answeredAlphabet, int index) {
    setState(() {

    });
  }
  @override
  void initState() {
    for(var i = 0;i< widget.trueAnswer.trim().split("").length;i++){
      yourAnswer.add({
        "answer": "",
        "index": -1
      });
    }
    getRandomAlphabet();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }
  void initData(){
    setState(() {
      yourAnswer = List.filled(
          widget.trueAnswer.trim().split("").length,{"answer": "","index": -1});
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            children: List.generate(widget.trueAnswer.trim().split("").length,
                (index) {
              return Stack(children: [
                AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    return Transform(
                      alignment: FractionalOffset.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0015)
                        ..rotateY(pi * animation.value),
                      child: child,
                    );
                  },
                  child: Card(
                    child: animation.value < 0.5
                        ? Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              color: Colors.black26, width: 0.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 3),
                              blurRadius: 3,
                              spreadRadius: 1,
                            )
                          ]),
                    )
                        : Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              color: Colors.black26, width: 0.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 3),
                              blurRadius: 3,
                              spreadRadius: 1,
                            )
                          ]),
                    ),
                  ),
                ),
                Positioned.fill(
                    child: InkWell(
                      onTap: (){
                        if(!isFullAnswered){
                          var item = yourAnswer[index];
                          if(item["index"] > -1){
                            setState(() {
                              quizRandomAlphabet[item["index"]] = item["answer"];
                              yourAnswer[index]["answer"] = "";
                              yourAnswer[index]["index"] = -1;
                            });
                          }
                        }
                      },
                      child: Align(
                          alignment: Alignment.center,
                          child: AnimatedOpacity(
                            opacity: controller.isAnimating ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 100),
                            child: Utils.customText(
                                text: yourAnswer[index]["answer"],
                                color: isFullAnswered?(yourAnswerIs? Colors.green : Colors.red) : Colors.black,
                                fontWeight: FontWeight.bold,
                                size: 20.0),
                          )),
                    ))
              ]);
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            children: List.generate(quizRandomAlphabet.length, (index) {
              return InkWell(
                onTap: () {
                  if(!isFullAnswered){
                    fillAnswer(quizRandomAlphabet[index], index);
                    clickedAlphabet(index);
                    var isCheckFull = yourAnswer.where((element) => element["answer"] !="").length == yourAnswer.length ;
                    if(isCheckFull){
                      controller.forward();
                      checkYourAnswer();
                      widget.checkResult(yourAnswerIs);
                      setState(() {
                        isFullAnswered= true;
                      });
                      widget.nextQuestions();
                    }
                  }
                },
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: quizRandomAlphabet[index] == "" ? 0 : 1.0,
                  child: Container(
                    height: 40,
                    width: 30,
                    decoration: BoxDecoration(
                        color: const Color(0xFF145DA0),
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Colors.black26, width: 0.5),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(2, 3),
                            blurRadius: 3,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Center(
                      child: Utils.customText(
                          text: quizRandomAlphabet[index],
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          size: 20.0),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
