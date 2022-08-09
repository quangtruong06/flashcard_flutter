import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flutter/material.dart';

class PlayRecord extends StatefulWidget {
  const PlayRecord({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayRecord> createState() => _PlayRecordState();
}

class _PlayRecordState extends State<PlayRecord> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> recordAnimate;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    recordAnimate = Tween<double>(begin: 50, end: 65).animate(controller);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            controller.forward();
            controller.addStatusListener((status) {
              if (controller.isCompleted) {
                controller.reverse();
              }
              if (controller.isDismissed){
                controller.forward();
              }
            });
          },
          child: SizedBox(
            height: 70,
            child: Center(
              child: Stack(children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget? child) {
                    return Container(
                      height: recordAnimate.value,
                      width: recordAnimate.value,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              style: BorderStyle.solid,
                              width: 1.0,
                              color: const Color(0xFFEEA12B))),
                    );
                  },
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Color(0xFFEEA12B), shape: BoxShape.circle),
                      child: const Icon(
                        Icons.mic_none_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Utils.customText(
          text: "Nhấn vào mic để nói",
          color: Colors.black87,
        )
      ],
    );
  }
}
