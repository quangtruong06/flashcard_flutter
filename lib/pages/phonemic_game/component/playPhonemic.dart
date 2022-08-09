import 'dart:math';

import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flashcard_flutter/pages/cardgame_page/model/cardgame_model.dart';
import 'package:flutter/material.dart';

class PlayPhonemic extends StatefulWidget {
  final CardModel phonemicData;

  const PlayPhonemic({Key? key, required this.phonemicData}) : super(key: key);

  @override
  State<PlayPhonemic> createState() => _PlayPhonemicState();
}

class _PlayPhonemicState extends State<PlayPhonemic>
    with TickerProviderStateMixin {
  final angle = 180 * pi / 180;
  bool isPlay = false;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    animation = Tween<double>(begin: 0, end: angle).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        controller.forward();
        controller.addStatusListener((status) {
          if (controller.value > 0.8) {
            setState(() {
              isPlay = true;
            });
            Future.delayed(const Duration(milliseconds: 500), () {
              controller.reverse();
              controller.addStatusListener((status) {
                if (controller.value < 0.8) {
                  setState(() {
                    isPlay = false;
                  });
                }
              });
            });
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        decoration: const BoxDecoration(
            color: Color(0xFF3f51b5),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(1.0),
              decoration: const BoxDecoration(
                  color: Color(0xFFEEA12B), shape: BoxShape.circle),
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(angle: animation.value, child: child);
                },
                child: isPlay
                    ? const Icon(
                        Icons.pause,
                        size: 35,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.volume_up,
                        size: 35,
                        color: Colors.white,
                      ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Utils.customText(
                    text: widget.phonemicData.name,
                    size: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const Spacer(),
            if (widget.phonemicData.phonemic != null)
              Utils.customText(
                  text: widget.phonemicData.phonemic!,
                  color: Colors.white,
                  size: 20.0)
          ],
        ),
      ),
    );
  }
}
