import 'package:flashcard_flutter/pages/cardgame_page/model/cardgame_model.dart';
import 'package:flashcard_flutter/widget/playaudio.dart';
import 'package:flutter/material.dart';

class PuzzleGameBody extends StatefulWidget {
  const PuzzleGameBody({
    Key? key,
    required this.size,
    required this.cardData,
  }) : super(key: key);

  final Size size;
  final List<CardModel> cardData;

  @override
  State<PuzzleGameBody> createState() => _PuzzleGameBodyState();
}

class _PuzzleGameBodyState extends State<PuzzleGameBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black26)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 50),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            height: widget.size.height / 2,
                            child: Image.network(widget.cardData[index].imageUrl!,fit: BoxFit.fill,),
                          ),
                          Positioned(
                            bottom: -15,
                              left: 0,
                              right: 0,
                              child: Center(child: PlayAudio(url: widget.cardData[index].mediaUrl!)))
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: widget.cardData.length,
            ),
          )
        ],
      ),
    );
  }
}
