import 'package:flashcard_flutter/components/share_widgets/route_transition.dart';
import 'package:flashcard_flutter/screens/mini_screens/SettingScreens.dart';
import 'package:flutter/material.dart';

import '../../utils/Utils.dart';

class TaxonomyDrawer extends StatelessWidget {
  const TaxonomyDrawer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width / 1.7,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: Color(0xFF3254AC),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset("assets/images/appicon.png",fit: BoxFit.fill,)

                    ),
                    Utils.customText(
                        text: "My FlashCards App",
                        color: Colors.white,
                        size: 18.0,
                        fontWeight: FontWeight.bold)
                  ],
                ),
              ),
              ListTile(
                title: const Text('Học Tiếng Anh'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Từ Yêu Thích'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Cài Đặt'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context, SlideLeftRoute(page: const SettingPage()));
                },
              ),
              ListTile(
                title: const Text('Chia Sẻ Ứng Dụng'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Đánh Giá Ứng Dụng'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(title: const Text('Hỗ Trợ'), onTap: () => null),
              ListTile(
                title: const Text('Phiên Bản 1.0'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}