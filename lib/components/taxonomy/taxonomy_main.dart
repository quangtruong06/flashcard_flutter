import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashcard_flutter/models/TaxonomyModel.dart';
import 'package:flashcard_flutter/network/response_api.dart';
import 'package:flashcard_flutter/components/share_widgets/route_transition.dart';
import 'package:flashcard_flutter/screens/CardScreen.dart';
import 'package:flashcard_flutter/utils/Globals.dart';
import 'package:flashcard_flutter/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TaxonomyBody extends StatefulWidget {
  final Size size;

  const TaxonomyBody({Key? key, required this.size}) : super(key: key);

  @override
  State<TaxonomyBody> createState() => _TaxonomyBodyState();
}

class _TaxonomyBodyState extends State<TaxonomyBody> {
  bool isDownloaded = false;
  var valueA = {};
  late Future<List<TaxonomyModel>> taxonomy;

  @override
  void initState() {
    taxonomy = getTaxonomiesFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: const Color(0xFFD5D8DC),
      child: FutureBuilder<List<TaxonomyModel>>(
          future: taxonomy,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<TaxonomyModel> data = snapshot.data!;
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
                              page: CardGamePage(data: data[index])));
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
                                RatingBarIndicator(
                                  rating: 4.5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                                const SizedBox(height: defaultPadding),
                                CachedNetworkImage(
                                  imageUrl: data[index].imageUrl!,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
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
                              Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: isDownloaded
                                      ? const Icon(
                                          Icons.cloud_download_outlined,
                                          color: Colors.blue,
                                        )
                                      : const Icon(
                                          Icons.check,
                                          color: Colors.blue,
                                        ))
                            ],
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
