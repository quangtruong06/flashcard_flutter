import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashcard_flutter/components/phonemic/playPhonemic.dart';
import 'package:flashcard_flutter/components/phonemic/playRecord.dart';
import 'package:flashcard_flutter/components/share_widgets/lastpage.dart';
import 'package:flashcard_flutter/models/cardgame_model.dart';
import 'package:flashcard_flutter/utils/Globals.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class PhonemicGameBody extends StatelessWidget {
  final Size size;
  final List<CardModel> cardData;
  final CarouselController buttonCarouselController = CarouselController();
  restartGame(){
    buttonCarouselController.jumpToPage(0);
  }
  PhonemicGameBody({Key? key, required this.size, required this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            height: size.height / 1.20,
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
                  return LastPage(title: data.tittle, imageSrc: data.imageSrc, description: data.description,restartGame: restartGame);
                }
                else{
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 6,
                            blurRadius: 10,
                            offset: const Offset(5, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: size.height / 2.5,
                            child: CachedNetworkImage(
                              imageUrl: cardData[index].imageUrl!,
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
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
                    ),
                  );
                }
              },
            );
          },
          itemCount: cardData.length+1,
        ),
      ],
    );
  }
}

