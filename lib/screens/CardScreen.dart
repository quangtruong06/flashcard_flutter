import 'package:flashcard_flutter/components/cardgames/cardgame_main.dart';

import 'package:flutter/material.dart';

import '../models/TaxonomyModel.dart';
import '../utils/Utils.dart';

class CardGamePage extends StatelessWidget {
  final TaxonomyModel data;

  const CardGamePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          backgroundColor: const Color(0xFF3254AC),
          title: Utils.customText(
              text: data.name,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              size: 20.0,
              fontStyle: FontStyle.italic),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFF2E4053), Color(0xFF3254AC)]),
            ),
          )),
      body: CardGameBody(
        data: data,
      ),
    );
  }
}
