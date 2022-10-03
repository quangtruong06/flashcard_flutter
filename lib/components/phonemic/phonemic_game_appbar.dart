
import 'package:flashcard_flutter/utils/Utils.dart';
import 'package:flutter/material.dart';

class PhonemicGameAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const PhonemicGameAppBar({Key? key, required this.cardType})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  final String cardType;

  @override
  State<PhonemicGameAppBar> createState() => _PhonemicGameAppBarState();

  @override
  final Size preferredSize;
}

class _PhonemicGameAppBarState extends State<PhonemicGameAppBar> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      backgroundColor: const Color(0xFF3254AC),
      title: Utils.customText(
          text: widget.cardType,
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
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: isFavorite
                ? const Icon(
              Icons.star,
              size: 30,
            )
                : const Icon(
              Icons.star_border_sharp,
              size: 30,
            ))
      ],
    );
  }
}