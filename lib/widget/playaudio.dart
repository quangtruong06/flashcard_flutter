import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayAudio extends StatefulWidget {
  const PlayAudio({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> with TickerProviderStateMixin {
  final player = AudioPlayer();
  final angle = 180 * pi / 180;
  bool isPlay = false;
  late AnimationController controller;
  late Animation<double> animation;
  init() async {
    await player.setUrl(widget.url);
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
    super.dispose();
    controller.dispose();
    player.stop();
    player.dispose();
  }
  void playPhonemic(){
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
            controller.addStatusListener((status){
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
    );
  }
}
