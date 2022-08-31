import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flutter/material.dart';

class NextBar extends StatefulWidget {
  const NextBar({
    Key? key,
    required this.size,
    required this.isNext,
    required this.nextPage,
    required this.stopNextQuestion,
  }) : super(key: key);
  final Function stopNextQuestion;
  final Size size;
  final bool isNext;
  final Function nextPage;

  @override
  State<NextBar> createState() => _NextBarState();
}

class _NextBarState extends State<NextBar> with TickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNext == true) {
      controller.forward();
      controller.addStatusListener((status) {
        if (controller.isCompleted) {
          widget.nextPage();
          widget.stopNextQuestion();
        }
      });
    }
    return AnimatedBuilder(
        animation: animation,
        builder: (context, Widget? child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(children: [
              LinearProgressIndicator(
                backgroundColor:
                    widget.isNext ? Colors.blue : Colors.blue.withOpacity(0.7),
                // backgroundColor: widget.isNext? Colors.blue : const Color(0xFF003060).withOpacity(0.3),
                value: animation.value,
                minHeight: 50,
                color: const Color(0xFF003060).withOpacity(0.3),
              ),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment.center,
                      child: Utils.customText(
                          text: "TIẾP THEO",
                          color: widget.isNext
                              ? Colors.white
                              : Colors.white.withOpacity(0.7),
                          size: 20.0,
                          fontWeight: FontWeight.bold)))
            ]),
          );
        });
  }
}
