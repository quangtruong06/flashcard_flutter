import 'package:flashcard_flutter/contain/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool switchStudy = false;
  bool switchDownload = false;

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
              text: "Cài Đặt",
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
      body: Container(
        color: const Color(0xFFEAEDF0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Utils.customText(
                  text: "Thông báo", color: Colors.black54, size: 20.0),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Utils.customText(text: "Bắt đầu học từ vựng"),
                  SizedBox(
                    height: 30,
                    child: CupertinoSwitch(
                      value: switchStudy,
                      onChanged: (value) {
                        setState(() {
                          switchStudy = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(width: 0.5, color: Colors.black12))),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Utils.customText(
                      text: "Số từ học trong ngày",
                      color: switchStudy ? Colors.black : Colors.black45),
                  Utils.customText(
                      text: "1",
                      color: switchStudy ? Colors.black : Colors.black45),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Utils.customText(
                  text: "Tải nội dung ngoại tuyến",
                  color: Colors.black54,
                  size: 20.0),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Utils.customText(text: "Chỉ tải khi kết nối wifi"),
                  SizedBox(
                    height: 30,
                    child: CupertinoSwitch(
                      value: switchDownload,
                      onChanged: (value) {
                        setState(() {
                          switchDownload = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(width: 0.5, color: Colors.black12))),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Utils.customText(
                      text: "Tất cả danh mục", color: Colors.black),
                  Utils.customText(text: "2.86%", color: Colors.black),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Utils.customText(
                  text: "Phiên bản", color: Colors.black54, size: 20.0),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Utils.customText(text: "1.0.0"),
            ),
          ],
        ),
      ),
    );
  }
}
