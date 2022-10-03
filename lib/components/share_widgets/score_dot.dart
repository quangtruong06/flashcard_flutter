import 'package:flutter/material.dart';

class ScoreDot extends StatefulWidget {
  final List<bool>? scoreDot;

  const ScoreDot({Key? key, @required this.scoreDot}) : super(key: key);

  @override
  State<ScoreDot> createState() => _ScoreDotState();
}

class _ScoreDotState extends State<ScoreDot> {
  Widget trueDot = Container(
    margin: const EdgeInsets.only(right: 5),
    width: 5,
    height: 5,
    decoration:
        const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
  );
  Widget falseDot = Container(
    margin: const EdgeInsets.only(right: 5),
    width: 5,
    height: 5,
    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
  );

  @override
  Widget build(BuildContext context) {
    // if(widget.yourResultIs==true){
    //   setState(() {
    //     widget.scoreDot.add(trueDot);
    //   });
    // }
    // else{
    //  setState(() {
    //    widget.scoreDot.add(falseDot);
    //  });
    // }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Wrap(
          spacing: 1,
          direction: Axis.horizontal,
          children: List.generate(widget.scoreDot!.length, (index) {
            bool isDot = widget.scoreDot![index];
            return Container(
              margin: const EdgeInsets.only(right: 5),
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                  color: isDot ? Colors.green : Colors.red,
                  shape: BoxShape.circle),
            );
          })),
    );
  }
}
