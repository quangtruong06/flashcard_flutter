import 'package:carousel_slider/carousel_slider.dart';
import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flashcard_flutter/pages/cardgame_page/model/cardgame_model.dart';
import 'package:flashcard_flutter/widget/playaudio.dart';
import 'package:flutter/material.dart';
class WordGameBody extends StatelessWidget {
  final Size size;
  final List<CardModel> cardData;
  const WordGameBody({Key? key, required this.size, required this.cardData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: size.height / 1.21,
              viewportFraction: 1,
              autoPlay: false,
              enableInfiniteScroll: false,
              initialPage: 0,
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black26)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            Positioned(child: PlayAudio(url: cardData[index].mediaUrl!)),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Utils.customText(
                                        text: cardData[index].name,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        size: 20.0)))
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            itemCount: cardData.length,
          ),
        ],
      ),
    );
  }
}
