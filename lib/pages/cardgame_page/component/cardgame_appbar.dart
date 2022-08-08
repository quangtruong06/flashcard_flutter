import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flutter/material.dart';

class CardGameAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const CardGameAppBar({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(0xFF3254AC),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            )),
        title: Utils.customText(
            text: title,
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
        ));
  }

  @override
  final Size preferredSize;
}
