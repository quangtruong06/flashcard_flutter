import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashcard_flutter/bloc/appscore_cubit.dart';
import 'package:flashcard_flutter/components/share_widgets/rating_bar.dart';
import 'package:flashcard_flutter/data_inherited.dart';
import 'package:flashcard_flutter/models/TaxonomyModel.dart';
import 'package:flashcard_flutter/models/cardgame_model.dart';
import 'package:flashcard_flutter/network/response_api.dart';
import 'package:flashcard_flutter/components/share_widgets/route_transition.dart';
import 'package:flashcard_flutter/screens/PuzzleGameScreen.dart';
import 'package:flashcard_flutter/screens/WordGameScreen.dart';
import 'package:flashcard_flutter/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/PhonemicScreen.dart';

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
    // var scoreData = AppScoreDataInherited.of(context)!.appScore;
    return BlocBuilder<ScoreCubit,dynamic>(builder: (context,state){
      print("aaaaaaaaa$state");
      return FutureBuilder<List<CardModel>>(
          future: cardData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var carddata = snapshot.data!;
              final List data = [
                {
                  "name": "Cards",
                  "img": widget.data.imageUrl,
                  "nextpage": PhonemicGame(
                    cardType: widget.data.name!,
                    cardData: carddata,
                  )
                },
                {
                  "name": "Word Game",
                  "img": "assets/images/word_game.png",
                  "nextpage": WordGame(
                    cardType: widget.data.name!,
                    cardData: carddata,
                  ),
                  "Score": state["WordGame"]
                },
                {
                  "name": "Puzzle Game",
                  "img": "assets/images/puzzle_game.png",
                  "nextpage": PuzzleGame(
                    cardType: widget.data.name!,
                    cardData: carddata,
                  ),
                  "Score": state["PuzzleGame"]
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SlideRightRoute(
                                      page: data[itemIndex]["nextpage"]));
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
                                    if (itemIndex != 0)
                                      MyRatingBar(
                                          itemSize: 25,
                                          rating: data[itemIndex]["Score"] * 5),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    itemIndex == 0
                                        ? CachedNetworkImage(
                                      imageUrl: data[0]["img"],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
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
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/smile_1.png",
                        width: 150,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Utils.customText(
                            text: "Loading Data...",
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3254AC)),
                      )
                    ],
                  ));
            }
          });
    });
  }
}
