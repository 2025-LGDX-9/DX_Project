import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/4thpage/my_page_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.controller});

  final PregnancyController controller;

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
                          onTap: () => {},
                          child: Image.asset(
                            "assets/images/announcement.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        SizedBox(width: 15),
                        // 메뉴 버튼
                        GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.settings),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(10),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color(0xffFFDEDE),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              right: 30,
                              left: 30,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ──────────────── 마이페이지 버튼 ────────────────
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>MyPageScreen(controller: controller,)));
                                    },
                                    child: Ink(
                                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      child: Text(
                                        "마이 페이지",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),

                                // 구분선
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: Colors.black54,
                                ),

                                // ──────────────── 고객지원 버튼 ────────────────
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      // TODO: 고객지원 이동
                                    },
                                    child: Ink(
                                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      child: Text(
                                        "고객 지원",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        // height: 800,
                        decoration: BoxDecoration(
                          color: Color(0xffEFEFEF)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("제품 사용과 관리", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 8,),
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Ink(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_circle_outlined,
                                                color: Color(
                                                  0xff7B60EB,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "스마트 진단",
                                                    style: TextStyle(
                                                      fontSize:
                                                      20,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Divider(height: 1),
                                      SizedBox(height: 12),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Icon(
                                              Icons
                                                  .info_rounded,
                                              color: Color(
                                                0xff436AE5,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "제품 정보와 보증",
                                                  style: TextStyle(
                                                    fontSize:
                                                    20,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Divider(height: 1),
                                      SizedBox(height: 12),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Icon(
                                              Icons.book,
                                              color: Color(
                                                0xff4EB1FF,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "제품 사용설명서",
                                                  style: TextStyle(
                                                    fontSize:
                                                    20,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Divider(height: 1),
                                      SizedBox(height: 12),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              color: Color(
                                                0xff4EB1FF,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "LG전자 구독",
                                                  style: TextStyle(
                                                    fontSize:
                                                    20,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text("제품 및 앱 활용", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 8,),
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Ink(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_home_outlined,
                                                color: Color(
                                                  0xffDB4F4F,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "ThinQ PLAY",
                                                    style: TextStyle(
                                                      fontSize:
                                                      20,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Divider(height: 1),
                                      SizedBox(height: 12),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Icon(
                                              Icons
                                                  .check_circle_rounded,
                                              color: Color(
                                                0xff7B60EB,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "스마트 루틴",
                                                  style: TextStyle(
                                                    fontSize:
                                                    20,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Divider(height: 1),
                                      SizedBox(height: 12),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Icon(
                                              Icons.where_to_vote,
                                              color: Color(
                                                0xff4EB1FF,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "ThinQ 활용하기",
                                                  style: TextStyle(
                                                    fontSize:
                                                    20,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text("쇼핑", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 8,),
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Ink(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .shopping_bag,
                                                color: Color(
                                                  0xff7B60EB,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "스토어",
                                                    style: TextStyle(
                                                      fontSize:
                                                      20,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text("제휴서비스", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 8,),
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Ink(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_home_work_rounded,
                                                color: Color(
                                                  0xff7B60EB,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "우리 단지",
                                                    style: TextStyle(
                                                      fontSize:
                                                      20,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Divider(height: 1),
                                      SizedBox(height: 12),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Icon(
                                              Icons
                                                  .lightbulb,
                                              color: Color(
                                                0xff436AE5,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "생활 서비스",
                                                  style: TextStyle(
                                                    fontSize:
                                                    20,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Divider(height: 1),
                                      SizedBox(height: 12),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Icon(
                                              Icons.fitness_center,
                                              color: Color(
                                                0xff4EB1FF,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "LG 피트니스",
                                                  style: TextStyle(
                                                    fontSize:
                                                    20,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Ink(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .science_outlined,
                                                color: Color(
                                                  0xff7B60EB,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "실험실",
                                                    style: TextStyle(
                                                      fontSize:
                                                      20,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
