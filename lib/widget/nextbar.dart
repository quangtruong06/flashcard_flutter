import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flutter/material.dart';
class NextBar extends StatefulWidget {
  const NextBar({
    Key? key,
    required this.size,
    required this.isNext,
  }) : super(key: key);

  final Size size;
  final bool isNext;
  @override
  State<NextBar> createState() => _NextBarState();
}

class _NextBarState extends State<NextBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width - 100,
      height: 50,
      decoration: BoxDecoration(
          color:
          widget.isNext ? const Color(0xFF03a9f4) : const Color(0xFF01579b),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
          child: Utils.customText(
              text: "TIẾP THEO",
              color: widget.isNext? Colors.white.withOpacity(0.7):Colors.grey.withOpacity(0.8),
              fontWeight: FontWeight.bold,size: 20.0)),
    );
  }
}