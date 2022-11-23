import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashcard_flutter/bloc/appscore_cubit.dart';
import 'package:flashcard_flutter/components/share_widgets/route_transition.dart';
import 'package:flashcard_flutter/screens/CardScreen.dart';
import 'package:flashcard_flutter/utils/Globals.dart';
import 'package:flashcard_flutter/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/TaxonomyModel.dart';
import '../../network/response_api.dart';
import '../share_widgets/rating_bar.dart';
class TaxonomyBody extends StatefulWidget {
  final Size size;
  const TaxonomyBody({Key? key, required this.size}) : super(key: key);
  @override
  State<TaxonomyBody> createState() => _TaxonomyBodyState();
}
class _TaxonomyBodyState extends State<TaxonomyBody> {
  late Future<List<TaxonomyModel>> taxonomy;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    taxonomy = getTaxonomiesFromApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TaxonomyModel>>(
        future: taxonomy,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List data = snapshot.data!;
            context.read<ScoreCubit>().setScoreLength(data.length);
            context.read<ScoreCubit>().listTotalScore();
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: (widget.size.width / 2 - 48) /
                        (widget.size.height / 3.5)),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            SlideRightRoute(
                                page: CardGamePage(
                              data: data[index]!,
                              index: index,
                            )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(1,2), // changes position of shadow
                            ),
                          ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<ScoreCubit, dynamic>(
                                      builder: (BuildContext context, state){
                                    double score = context.read<ScoreCubit>().totalScores[index];
                                    return MyRatingBar(
                                        itemSize: 20.0, rating: score*5);
                                  }),
                                  const SizedBox(height: defaultPadding),
                                  CachedNetworkImage(
                                    imageUrl: data[index].imageUrl!,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  Utils.customText(
                                      text: data[index].name,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: defaultPadding),
                              child: Utils.customText(
                                  text: "Total Cards: ${data[index].totalFlashCards}",color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ));
                },
                itemCount: data.length);
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
  }
}
