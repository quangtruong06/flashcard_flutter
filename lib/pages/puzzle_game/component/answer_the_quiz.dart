import 'dart:math';
import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flutter/material.dart';

class PlayQuiz extends StatefulWidget {
  final String trueAnswer;

  const PlayQuiz({Key? key, required this.trueAnswer}) : super(key: key);

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}
class _PlayQuizState extends State<PlayQuiz> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  List yourAnswer = [];
  List quizRandomAlphabet = [];
  bool isClicked = false;
  bool yourAnswerIs = false;
  checkYourAnswer(){
    setState(() {
      if (yourAnswer.join()==widget.trueAnswer.trim()){
        yourAnswerIs = true;
      }
      else{
        yourAnswerIs = false;
      }
    });
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
      quizRandomAlphabet[index] = answeredAlphabet;
    });
  }
  @override
  void initState() {
    yourAnswer = List.filled(
        widget.trueAnswer.trim().split("").length,{"answer": "","index": 0});
    getRandomAlphabet();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    for(Map map in yourAnswer){
      if(map.containsKey("answer")){
        if(map["answer"]!=""){
          checkYourAnswer();
          controller.forward();
        }
      }
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
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
                    child: InkWell(
                      onTap: () {
                        returnAlphabet(yourAnswer[index]["answer"],
                            yourAnswer[index]["index"]);
                        setState(() {
                          yourAnswer[index]["answer"] = "";
                        });
                      },
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
                ),
                Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: AnimatedOpacity(
                          opacity: controller.isAnimating ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 100),
                          child: Utils.customText(
                              text: yourAnswer[index]["answer"],
                              color: yourAnswerIs!? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                              size: 20.0),
                        )))
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
                  fillAnswer(quizRandomAlphabet[index], index);
                  clickedAlphabet(index);
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
