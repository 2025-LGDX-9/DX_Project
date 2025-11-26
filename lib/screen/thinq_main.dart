import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/nofification_screen.dart';

import '../pregnancy_controller.dart';
import '../screens/onboarding_screen.dart';

Widget _buildTopBackground() {
  return Container(
    width: double.infinity,
    height: 250,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF3B5BA9), // 밝은 파란색 (위쪽)
          Color(0xFF0D1A3A), // 어두운 네이비 (아래)
        ],
      ),
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    ),
  );
}


class ThinqHomeScreen extends StatelessWidget {
  const ThinqHomeScreen({super.key, required this.controller});
  final PregnancyController controller;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1A3A), // ThinQ 스타일 네이비
      body: Stack(
          children: [
            // 상단 네비게이션 + 프로필
            _buildTopBackground(),

            // 스크롤 전체 영역
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    _buildUserHomeTitle(),
                    Row(
                      children: [
                        // 추가 등록 버튼
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true, // ★ 패널 높이 직접 제어 가능
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xffEFF1F4),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24), // ★ 위쪽만 둥글게
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 12),
                                        Container(
                                          width: 40,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        // ★ 내부 내용
                                        Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            children: [
                                              //임산부 등록 버튼
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>OnboardingScreen(controller: controller,onCompleted: (){},)));},
                                                  child: Ink(
                                                    width: MediaQuery.of(
                                                      context,
                                                    ).size.width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(20),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Icon(
                                                            Icons.pregnant_woman,
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                "임산부 모드",
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "설명",
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12),
                                              //제품 추가 버튼
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Ink(
                                                    width: MediaQuery.of(
                                                      context,
                                                    ).size.width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(20),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Icon(
                                                            Icons.add_circle,
                                                            color: Color(
                                                              0xff43BA84,
                                                            ),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                "제품 추가",
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "LG와 다양한 브랜드의 제품",
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12),
                                              //씽큐 플레이
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Ink(
                                                    width: MediaQuery.of(
                                                      context,
                                                    ).size.width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(20),
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
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                "ThinQ PLAY",
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "앱 다운로드와 제품 업그레이드",
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12),
                                              Material(
                                                color: Colors.transparent,
                                                child: Ink(
                                                  width: MediaQuery.of(
                                                    context,
                                                  ).size.width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(20),
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
                                                                      .check_circle_rounded,
                                                                  color: Color(
                                                                    0xff7B60EB,
                                                                  ),
                                                                ),
                                                                SizedBox(width: 10,),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      "루틴 만들기",
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
                                                          onTap: (){},
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .add_home_work_rounded,
                                                                color: Color(
                                                                  0xff436AE5,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    "우리 단지 연결",
                                                                    style: TextStyle(
                                                                      fontSize: 20,
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
                                                          onTap: (){},
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons.drafts,
                                                                color: Color(
                                                                  0xff4EB1FF,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    "3D 홈뷰 만들기",
                                                                    style: TextStyle(
                                                                      fontSize: 20,
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
                                              SizedBox(height: 12),
                                              Material(
                                                color: Colors.transparent,
                                                child: Ink(
                                                  width: MediaQuery.of(
                                                    context,
                                                  ).size.width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(20),
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
                                                                      .person_add,
                                                                  color: Color(
                                                                    0xff909090,
                                                                  ),
                                                                ),
                                                                SizedBox(width: 10,),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      "멤버 초대",
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
                                                          onTap: (){},
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .add_home,
                                                                color: Color(
                                                                  0xff0298EB,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    "새로운 홈 만들기",
                                                                    style: TextStyle(
                                                                      fontSize: 20,
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
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              "assets/images/pregnant_register.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        // 알림 버튼
                        GestureDetector(
                          onTap: ()=>{Navigator.push(context, MaterialPageRoute(builder: (_)=>notification()))},
                          child: Image.asset(
                            "assets/images/notification.png",
                            width: 25,
                            height: 25,
                          ),
                        ),
                        SizedBox(width: 10,),
                        // 메뉴 버튼
                        PopupMenuButton(
                          offset: Offset(0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Color(0xff2E2E2E),
                          itemBuilder: (context) => <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "화면 편집",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(Icons.edit, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                            PopupMenuDivider(height: 1, color: Colors.white24,),
                            PopupMenuItem(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "홈 설정",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(Icons.settings, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          child: Image.asset(
                            "assets/images/menu.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ],),


                    const SizedBox(height: 10),

                    // 메인 배너들
                    _buildMainBanner(
                      title: "ThinQ와 함께하는 스마트 홈,\n제품을 연결해 새로운 일상을 만나보세요.",
                      buttonText: "더 알아보기",
                      imagePath: "assets/images/homeimg1.png",
                    ),
                    _buildMainBanner(
                      title:
                      "3D 홈뷰로 우리집과 제품의 실시간\n상태를 한눈에 확인해보세요.",
                      buttonText: "3D 홈뷰 만들기",
                      imagePath: "assets/images/homeimg2.png",
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle("즐겨 찾는 제품"),
                    _emptyFavoriteBox(),

                    const SizedBox(height: 15),

                    _thinqPlayBanner(),

                    const SizedBox(height: 25),

                    _sectionTitle("스마트 루틴"),
                    _routineButton(),

                    const SizedBox(height: 25),

                    _sectionTitle("ThinQ 활용하기"),
                    _bigImageCard(
                      title: "TV도 ThinQ 앱으로 스마트하게 즐겨요",
                      subtitle: "ThinQ 앱으로 TV를 제어할 수 있어요",
                      imagePath: "assets/images/tv.png",
                    ),

                    const SizedBox(height: 25),

                    _sectionTitle("새로운 소식"),
                    _bigImageCard(
                      title: "Life's Good Kitchen",
                      subtitle:
                      "맛있는 상상이 시작되는 공간으로 놀러오세요\n핫한 레시피부터 요리 꿀팁까지 인스타그램에서 확인해보세요",
                      imagePath: "assets/images/kitchen.png",
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  // --------------------------- 위젯 묶음 -----------------------------

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: Colors.white, size: 26),
          Row(
            children: const [
              Icon(Icons.add, color: Colors.white, size: 26),
              SizedBox(width: 18),
              Icon(Icons.notifications_outlined, color: Colors.white, size: 26),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildUserHomeTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: const [
          Text(
            "사용자 홈",
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
          Icon(Icons.arrow_drop_down, color: Colors.white, size: 30),
        ],


      ),
    );
  }

  Widget _buildMainBanner({required String title, required String buttonText, required String imagePath}) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF30333A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4)),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _emptyFavoriteBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade700, width: 1, style: BorderStyle.solid),
      ),
      child: const Text(
        "제품을 추가해주세요. 제품을 즐겨 찾는 제품에 추가하면 홈 화면에서 바로 사용할 수 있어요.",
        style: TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }

  Widget _thinqPlayBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.pinkAccent],
        ),
      ),
      child: const Text(
        "ThinQ PLAY\n앱을 다운로드하여 제품과 공간을 업그레이드해보세요.",
        style: TextStyle(color: Colors.white, fontSize: 15, height: 1.3),
      ),
    );
  }

  Widget _routineButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF424549),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: const [
          Icon(Icons.access_time, color: Colors.orangeAccent),
          SizedBox(width: 12),
          Text("루틴 알아보기", style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _bigImageCard({required String title, required String subtitle, required String imagePath}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF30333A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$title\n$subtitle",
              style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
