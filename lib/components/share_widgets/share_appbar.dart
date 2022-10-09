import 'package:flashcard_flutter/utils/Utils.dart';
import 'package:flutter/material.dart';

class ShareAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const ShareAppBar({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(0xFF3254AC),
        leading: IconButton(
            onPressed: (){
            // Navigator.pop(context);
              showDialog(barrierDismissible: false,context: context, builder: (_){
                return AlertDialog(
                  title: Utils.customText(text: "Bạn có chắc chắn muốn thoát?",fontWeight: FontWeight.bold,size: 20.0),
                  content: Utils.customText(text: "Thoát sẽ không được tính điểm",fontWeight: FontWeight.bold,size: 16.0),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Utils.customText(text: "Chơi tiếp",color: Colors.blue),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Utils.customText(text: "Thoát ra",color: Colors.red),
                    ),
                  ],
                );
              });
            },
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
