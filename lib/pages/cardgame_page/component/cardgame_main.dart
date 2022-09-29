import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flashcard_flutter/contain/response_api.dart';
import 'package:flashcard_flutter/pages/cardgame_page/model/cardgame_model.dart';
import 'package:flashcard_flutter/pages/phonemic_game/phonemic_game.dart';
import 'package:flashcard_flutter/pages/puzzle_game/puzzle_game.dart';
import 'package:flashcard_flutter/pages/taxonomy_page/model/taxonomy_model.dart';
import 'package:flashcard_flutter/pages/word_game/word_game.dart';
import 'package:flashcard_flutter/route_transition/route_transition.dart';
import 'package:flashcard_flutter/widget/lastpage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CardGameBody extends StatefulWidget {
  final TaxonomyModel data;

  const CardGameBody({Key? key, required this.data}) : super(key: key);

  @override
  State<CardGameBody> createState() => _CardGameBodyState();
}

class _CardGameBodyState extends State<CardGameBody> {
  Future<List<CardModel>>? cardData;

  @override
  void initState() {
    cardData = getCardDataFromAPI(widget.data.taxonomyId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CardModel>>(
        future: cardData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var carddata = snapshot.data!;
            final List data = [
              {
                "name": "Cards",
                "img": widget.data.imageUrl,
                "nextpage":PhonemicGame(cardType: widget.data.name!, cardData: carddata,)
              },
              {
                "name": "Word Game",
                "img": "assets/images/word_game.png",
                "nextpage": WordGame(cardType: widget.data.name!, cardData: carddata,)
              },
              {
                "name": "Puzzle Game",
                "img": "assets/images/puzzle_game.png",
                "nextpage": PuzzleGame(cardType: widget.data.name!, cardData: carddata,)
              }
            ];
            return Center(
              child: CarouselSlider.builder(
                  itemCount: data.length,
                  options: CarouselOptions(
                    aspectRatio: 16 / 17,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    initialPage: 0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Builder(
                      builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, SlideRightRoute(page: data[itemIndex]["nextpage"]));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(2, 10))
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    itemIndex == 0
                                        ? Image.network(
                                      data[0]["img"],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    )
                                        : Image.asset(
                                      data[itemIndex]["img"],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    Utils.customText(
                                        text: data[itemIndex]["name"],
                                        size: 30.0,
                                        fontWeight: FontWeight.bold)
                                  ],
                                )),
                          );
                      },
                    );
                  }),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
