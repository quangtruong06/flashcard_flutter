import 'package:flashcard_flutter/screens/TaxonomyScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlashCardApp());
}

class FlashCardApp extends StatelessWidget {
  const FlashCardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Taxonomy(),
    );
  }
}
