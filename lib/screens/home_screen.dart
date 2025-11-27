import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/onboarding_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/nofification_screen.dart';

class HomeScreen extends StatelessWidget {
  final PregnancyController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final weeks = controller.weeks;
    final babyName = controller.babyNickname ?? '우리 아기';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xffFAF0F0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //상단 바
                  Flexible(
                    child: Row(
                      children: [
                        Text(
                          "홈",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        // 홈 변경 버튼
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "assets/images/keyboard_arrow_down.png",
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          OnboardingScreen(
                                                            controller:
                                                                controller,
                                                            onCompleted: () {},
                                                          ),
                                                    ),
                                                  );
                                                },
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
                                                        SizedBox(width: 10),
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
                                                        SizedBox(width: 10),
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
                                                        SizedBox(width: 10),
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
                                                              SizedBox(
                                                                width: 10,
                                                              ),
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
                                                        onTap: () {},
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
                                                            SizedBox(width: 10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "우리 단지 연결",
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
                                                              Icons.drafts,
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
                                                                  "3D 홈뷰 만들기",
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
                                                              SizedBox(
                                                                width: 10,
                                                              ),
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
                                                        onTap: () {},
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.add_home,
                                                              color: Color(
                                                                0xff0298EB,
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "새로운 홈 만들기",
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
                      SizedBox(width: 10),
                      // 알림 버튼
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => notification()),
                          ),
                        },
                        child: Image.asset(
                          "assets/images/notification.png",
                          width: 25,
                          height: 25,
                        ),
                      ),
                      SizedBox(width: 10),
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
                          PopupMenuDivider(height: 1, color: Colors.white24),
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
                ],
              ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      babyName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.dDayString.isEmpty
                          ? '임신 ${weeks}주차'
                          : controller.dDayString,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 16),
                    _buildBabyCard(weeks),
                    const SizedBox(height: 24),
                    const Text(
                      '임신 주차 꿀팁',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const _TipCard(
                      title: '오늘의 생활 꿀팁',
                      description: '가습기를 40–60%로 유지해보세요.',
                      buttonText: '오늘의 영양제 추천 보기',
                      icon: Icons.medication_outlined,
                    ),
                    const SizedBox(height: 24),
                    // const Text(
                    //   '에어컨 온도 조절',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // const _TemperatureControl(),
                    _buildFavoriteDevicesSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBabyCard(int weeks) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xfffde4ea),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '저는 지금 헤엄치는 중이에요',
              style: TextStyle(color: Colors.red.shade400),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: Image.asset(
              'assets/images/baby.png', // 네가 넣은 태아 이미지
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '임신 ${weeks}주차에는 이런 걸 해보세요!',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final IconData icon;

  const _TipCard({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(description),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(icon, size: 18),
            label: Text(buttonText),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TemperatureControl extends StatefulWidget {
  const _TemperatureControl();

  @override
  State<_TemperatureControl> createState() => _TemperatureControlState();
}

class _TemperatureControlState extends State<_TemperatureControl> {
  double _value = 25;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('권장 범위: 24–26°C'),
        const SizedBox(height: 8),
        Text(
          '${_value.toStringAsFixed(0)}°C',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: _value,
          min: 18,
          max: 30,
          onChanged: (v) {
            setState(() => _value = v);
          },
        ),
        const Text('적정 온도입니다. 몸이 춥거나 덥지 않은지 한 번 더 체크해 주세요.'),
      ],
    );
  }
}

class FavoriteDeviceCard extends StatelessWidget {
  final String name;
  final String status;
  final IconData icon;

  const FavoriteDeviceCard({
    super.key,
    required this.name,
    required this.status,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            status,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildFavoriteDevicesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '즐겨 찾는 제품',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),

      // 가로 스크롤 카드 리스트
      SizedBox(
        height: 110,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            FavoriteDeviceCard(
              name: '냉장고',
              status: '냉장 온도 3℃',
              icon: Icons.kitchen,
            ),
            FavoriteDeviceCard(
              name: '전기레인지',
              status: '보온 모드',
              icon: Icons.microwave,
            ),
            FavoriteDeviceCard(
              name: 'TV',
              status: '꺼짐',
              icon: Icons.tv,
            ),
            FavoriteDeviceCard(
              name: '공기청정기',
              status: '케어 중',
              icon: Icons.air,
            ),
          ],
        ),
      ),
    ],
  );
}
