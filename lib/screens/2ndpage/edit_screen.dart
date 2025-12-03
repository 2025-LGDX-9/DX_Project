import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false, // 기본 leading 제거
        titleSpacing: 0, // 좌측 여백 제거
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black54,),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 1), // 제목과의 간격 최소화
                Text(
                  "가전 추가",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}