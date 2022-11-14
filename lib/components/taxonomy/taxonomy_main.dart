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
                                      builder: (BuildContext context, state) {
                                    double score = (state[index]["WordGame"] +
                                            state[index]["PuzzleGame"]) /
                                        2 *
                                        5;
                                    return MyRatingBar(
                                        itemSize: 20.0, rating: score);
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Utils.customText(
                                    text: "${data[index].totalFlashCards}"),
                                const Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Icon(
                                      Icons.cloud_download_outlined,
                                      color: Colors.blue,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: defaultPadding,
                            )
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
