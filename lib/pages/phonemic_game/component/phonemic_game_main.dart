import 'package:flashcard_flutter/contain/Globals.dart';
import 'package:flashcard_flutter/pages/cardgame_page/model/cardgame_model.dart';
import 'package:flashcard_flutter/pages/phonemic_game/component/playPhonemic.dart';
import 'package:flashcard_flutter/pages/phonemic_game/component/playRecord.dart';
import 'package:flashcard_flutter/widget/lastpage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class PhonemicGameBody extends StatelessWidget {
  final Size size;
  final List<CardModel> cardData;

  const PhonemicGameBody({Key? key, required this.size, required this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            height: 30,
          ),
          CarouselSlider.builder(
            options: CarouselOptions(
              height: size.height / 1.3,
              viewportFraction: 1,
              autoPlay: false,
              enableInfiniteScroll: false,
              initialPage: 0,
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Builder(
                builder: (BuildContext context) {
                  if(index==cardData.length){
                    final PhonemicLastPageData data = PhonemicLastPageData();
                    return LastPage(title: data.tittle, imageSrc: data.imageSrc, description: data.description);
                  }
                  else{
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black26)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: size.height / 2.5,
                            child: Image.network(cardData[index].imageUrl!),
                          ),
                          PlayPhonemic(phonemicData: cardData[index]),
                          const SizedBox(
                            height: 16,
                          ),
                          HtmlWidget(cardData[index].description!,
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 20)),
                          const Expanded(child: PlayRecord())
                        ],
                      ),
                    );
                  }
                },
              );
            },
            itemCount: cardData.length+1,
          ),
        ],
      ),
    );
  }
}

