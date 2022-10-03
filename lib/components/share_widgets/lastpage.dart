
import 'package:flutter/material.dart';

import '../../utils/Utils.dart';

class LastPage extends StatelessWidget {
  Function? restartGame;
  String? title;
  String? imageSrc;
  String? description;
  String restart = "xem từ đầu";
  String playGame = "chơi game";
  LastPage({super.key, required this.title,required this.imageSrc,required this.description,this.restartGame});
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
            Image.asset(imageSrc!,width: 100,),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Utils.customText(text: description!,fontWeight: FontWeight.bold,size: 18.0),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                restartGame!();
              },
              child: Container(
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
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
