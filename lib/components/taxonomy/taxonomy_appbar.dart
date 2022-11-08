import 'package:flashcard_flutter/utils/Utils.dart';
import 'package:flutter/material.dart';

class TaxonomyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaxonomyAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(0xFF3254AC),
        actions: [
          IconButton(
              onPressed: () => null,
              icon: const Icon(
                Icons.search_sharp,
                size: 30,
              )),
        ],
        title: Utils.customText(
            text: "FlashCards",
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
}
