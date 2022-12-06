import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

import '../../models/cardgame_model.dart';
import '../../utils/Utils.dart';

class PlayPhonemic extends StatefulWidget {
  final CardModel phonemicData;

  const PlayPhonemic({Key? key, required this.phonemicData}) : super(key: key);

  @override
  State<PlayPhonemic> createState() => _PlayPhonemicState();
}

class _PlayPhonemicState extends State<PlayPhonemic>
    with TickerProviderStateMixin {
  final player = AudioPlayer();
  final angle = 180 * pi / 180;
  bool isPlay = false;
  late AnimationController controller;
  late Animation<double> animation;

  init() async {
    var url = widget.phonemicData.mediaUrl;
    await player.setUrl(url!);
  }

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    animation = Tween<double>(begin: 0, end: angle).animate(controller);
    init();
    playPhonemic();
    super.initState();
  }

  @override
  void dispose() {

    controller.dispose();
    player.stop();
    super.dispose();
  }

  void playPhonemic() {
    controller.forward();
    controller.addStatusListener((status) {
      if (controller.isCompleted) {
        setState(() {
          isPlay = true;
          player.play();
        });
        player.playbackEventStream.listen((event) {
          if (event.processingState == ProcessingState.completed) {
            controller.reverse();
            controller.addStatusListener((status) {
              if (controller.value < 0.8) {
                setState(() {
                  isPlay = false;
                });
                player.pause();
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        playPhonemic();
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
