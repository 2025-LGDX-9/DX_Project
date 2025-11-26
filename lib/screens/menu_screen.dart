import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Color(0xffFAF0F0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Text(
                              "LG ThinQ",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          // 알림 버튼
                          GestureDetector(
                            onTap: ()=>{},
                            child: Image.asset(
                              "assets/images/announcement.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          SizedBox(width: 15,),
                          // 메뉴 버튼
                          GestureDetector(
                            onTap: (){},
                            child: Icon(Icons.settings),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
      )),
    );
  }
}
