import 'package:flashcard_flutter/contain/Globals.dart';
import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TaxonomyBody extends StatelessWidget {
  bool isDownloaded = false;
  final Size size;
  TaxonomyBody({Key? key, required this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      color: const Color(0xFFD5D8DC),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio:
            (size.width / 2 - 48) / (size.height / 3.5)
        ), itemBuilder: (context, index) {
        return GestureDetector(
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
                          itemBuilder: (context, index) =>
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(height: defaultPadding),
                        Image.network(
                          "",
                          fit: BoxFit.cover,
                          width: 100,
                        ),
                        SizedBox(height: defaultPadding),
                        Utils.customText(text: "Hello",
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Utils.customText(
                          text: "hello"),
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
                   SizedBox(
                    height: defaultPadding,
                  )
                ],
              ),
            ),
        );
      }, itemCount: 100,),
    );
  }
}
