import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flutter/material.dart';

class LastPage extends StatelessWidget {
  String? title;
  String? imageSrc;
  String? description;
  String restart = "xem từ đầu";
  String playGame = "chơi game";
  LastPage({super.key, required this.title,required this.imageSrc,required this.description});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/win.png"), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Utils.customText(text: title!,fontWeight: FontWeight.bold,color: const Color(0xFF3254AC),size: 20.0),
            const SizedBox(height: 20,),
            Image.asset(imageSrc!,width: 30,),
            Utils.customText(text: description!),
            const SizedBox(height: 20,),
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Center(
                child: Utils.customText(text: restart.toUpperCase(),fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Center(
                child: Utils.customText(text: playGame.toUpperCase(),fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
