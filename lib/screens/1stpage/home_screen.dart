import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pregnancy_mode_app/models/all_device.dart';
import 'package:pregnancy_mode_app/models/favorite_device.dart';
import 'package:pregnancy_mode_app/screens/1stpage/calendar_screen.dart';
import 'package:pregnancy_mode_app/screens/1stpage/enter_group.dart';

// import 'package:pregnancy_mode_app/screens/1stpage/enter_group.dart';
import 'package:pregnancy_mode_app/screens/1stpage/onboarding_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/1stpage/tutorial_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/edit_screen.dart';
import 'package:pregnancy_mode_app/screens/appbar/nofification_screen.dart';
import 'package:pregnancy_mode_app/services/api_service.dart';
import 'package:pregnancy_mode_app/services/favorite_service.dart';
import 'package:intl/intl.dart';

import 'check_group.dart';

class HomeScreen extends StatefulWidget {
  final PregnancyController controller;
  final bool showTutorial;
  final Function(bool)? onPregnancyModeChanged;

  const HomeScreen({
    super.key,
    required this.controller,
    this.showTutorial = false,
    this.onPregnancyModeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _tipMessages = [
    // 축하 메시지 리스트 추가
    "이 시기엔 카페인 섭취를 조금 줄여보는 게 좋아요.",
    "임신 15주차에는 옆으로 누워 자는 습관을 들이면 더 편안해요.",
    "지금은 칼슘이 풍부한 음식을 챙겨 먹어주는 것이 도움이 돼요.",
    "이 때는 물을 자주 마셔서 치질·변비를 예방해보세요.",
    "이 시점엔 가벼운 산책으로 기분을 환기해보는 것이 좋아요.",
    "이 즈음엔 구강 관리를 꼼꼼히 해주면 치은염 예방에 도움이 돼요.",
    "이 주차에는 오래 앉아 있기보다 중간중간 움직여주는 게 좋아요.",
    "이 과정에서는 부드러운 스트레칭으로 몸의 긴장을 풀어주세요.",
    "이 시기 특성상 감정 기복이 있을 수 있으니 충분히 휴식하세요.",
  ];

  final List<String> _deviceTipMessages = [
    "실내 온도를 24–26°C로 유지해보세요.",
    "가습기를 40–60%로 설정해두면 편안해요.",
    "취침 전 에어컨 바람세기는 약풍으로 낮춰보세요.",
    "이 시기엔 공기청정기를 자동 모드로 켜두는 게 좋아요.",
    "집안 먼지를 줄이기 위해 로봇청소기를 매일 한 번 돌려보세요.",
    "피부와 점막 건조를 막기 위해 실내 공기를 신선하게 유지해보세요.",
    "밤에는 조명을 20–40%로 낮춰두면 숙면에 도움이 돼요.",
    "임산부는 소음에 민감할 수 있어 공기청정기·가습기에 취침모드를 사용해보세요.",
  ];

  final List<String> _supplementTipMessages = [
    "엽산 – 태아 신경관 형성을 위해 꼭 필요한 기본 영양제예요.",
    "철분 – 임신 중기 이후 증가하는 혈액량을 보충해 피로를 줄여줘요.",
    "비타민D – 칼슘 흡수를 돕고 면역력을 유지하는 데 중요해요.",
    "칼슘 – 태아 뼈 발달을 위해 하루 1000mg 정도 꼭 챙겨주세요.",
    "요오드 – 갑상선 호르몬 생성에 필요하지만 과다 섭취는 피해야 해요.",
    "오메가3 – 조산 위험을 낮추고 태아 뇌 발달에 도움을 줄 수 있어요.",
    "유산균 – 장 건강을 돕지만 체질마다 다를 수 있어 의사 상담이 좋아요.",
    "비타민A 주의 – 5000 IU 이상 장기 복용은 기형 위험이 있어 피해야 해요.",
  ];

  String _randomTip = "";
  String _randomDeviceTip = "";

  bool _editMode = false;
  String _babyName = "우리 아기";

  @override
  void initState() {
    super.initState();
    _checkAndShowTutorial();

    // ★ Onboarding 이후 첫 진입이면 튜토리얼 화면 띄우기
    if (widget.showTutorial) {
      Future.delayed(const Duration(milliseconds: 150), () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const TutorialScreen(),
        );
      });
    }

    _randomTip = _tipMessages[Random().nextInt(_tipMessages.length)];
    _randomDeviceTip =
        _deviceTipMessages[Random().nextInt(_deviceTipMessages.length)];
    _babyName = widget.controller.babyNickname ?? "우리 아기";
  }

  void _checkAndShowTutorial() {
    final box = Hive.box('onboarding');
    final shown = box.get('tutorialShown', defaultValue: false);

    if (!shown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const TutorialScreen(),
        );

        // 다시는 안 뜨도록 저장
        box.put('tutorialShown', true);
      });
    }
  }

  void _showSupplementPopup() {
    final randomMessage =
        _supplementTipMessages[Random().nextInt(_supplementTipMessages.length)];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "오늘의 영양제 추천",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(randomMessage, style: const TextStyle(fontSize: 14)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('pregnancyBox');
    _babyName = box.get('nickname', defaultValue: "우리 아기");

    final savedDate = box.get('startDate');
    if (savedDate != null) {
      widget.controller.setStartDate(DateTime.parse(savedDate));
    }

    final weeks = widget.controller.weeks;

    Text(
      _babyName,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );

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
                  Expanded(
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
                                final onboardBox = Hive.box('onboarding');
                                final hasPregnancyInfo = onboardBox.get(
                                  'pregnancyMode',
                                  defaultValue: false,
                                );

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
                                            if (hasPregnancyInfo)
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    onboardBox.put(
                                                      'pregnancyMode',
                                                      false,
                                                    ); // DB 저장

                                                    // ★ main에게 전달 → 화면 전환 발생
                                                    if (widget
                                                            .onPregnancyModeChanged !=
                                                        null) {
                                                      widget
                                                          .onPregnancyModeChanged!(
                                                        false,
                                                      );
                                                    }

                                                    Navigator.pop(context);
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
                                                      padding: EdgeInsets.all(
                                                        20,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "임산부 모드 해제",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            else
                                              // =============================
                                              // 임산부 모드 OFF 상태 → 기존 '임산부 등록' 버튼 그대로
                                              // =============================
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            OnboardingScreen(
                                                              controller: widget
                                                                  .controller,
                                                              onCompleted:
                                                                  () {},
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
                                                      padding: EdgeInsets.all(
                                                        20,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .pregnant_woman,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "임산부 모드",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
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
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          EditScreen(),
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
                                                        onTap: () {
                                                          final box = Hive.box(
                                                            'pregnancyBox',
                                                          );
                                                          final groupCode = box
                                                              .get(
                                                                'unique_key',
                                                                defaultValue:
                                                                    "TEST123",
                                                              );

                                                          print(
                                                            "🔥 Loaded groupCode = $groupCode",
                                                          );

                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  CheckGroup(
                                                                    groupCode:
                                                                        groupCode,
                                                                  ),
                                                            ),
                                                          );
                                                        },
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
                      _babyName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.controller.dDayString.isEmpty
                          ? '임신 ${weeks}주차'
                          : widget.controller.dDayString,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 16),
                    _buildBabyCard(weeks),
                    const SizedBox(height: 24),
                    ValueListenableBuilder(
                      valueListenable: Hive.box("diary").listenable(),
                      builder: (context, box, _) {
                        return TodayDiarySummaryCard();
                      },
                    ),
                    SizedBox(height: 24),
                    const Text(
                      '임신 주차 꿀팁',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _TipCard(
                      title: '오늘의 생활 꿀팁',
                      description: _randomDeviceTip,
                      buttonText: '오늘의 영양제 추천 보기',
                      icon: Icons.medication_outlined,
                      onPressed: _showSupplementPopup,
                    ),
                    const SizedBox(height: 24),
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

  Widget _buildFavoriteDevicesSection() {
    final favorites = FavoriteService.getFavorites();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '즐겨 찾는 제품',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),

            /// 편집 모드 토글 버튼
            IconButton(
              icon: Icon(_editMode ? Icons.check : Icons.edit, size: 20),
              onPressed: () {
                setState(() {
                  _editMode = !_editMode;
                });
              },
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// 1) 즐겨찾기 없고 편집모드도 아닐 때 → 안내 문구
        if (favorites.isEmpty && !_editMode)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            alignment: Alignment.center,
            child: const Text(
              "즐겨찾기한 제품이 없습니다.",
              style: TextStyle(color: Colors.grey),
            ),
          ),

        /// 2) 즐겨찾기 있거나 편집모드일 때 → 리스트 표시
        if (favorites.isNotEmpty || _editMode)
          SizedBox(
            height: 116,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                /// 즐겨찾기 카드들
                for (var d in favorites)
                  FavoriteDeviceCard(
                    name: d.name,
                    icon: IconData(d.iconCode, fontFamily: 'MaterialIcons'),
                    type: d.type,
                    // ★ 추가됨
                    controller: widget.controller,
                    // ★ 추가됨
                    showDelete: _editMode,
                    onDelete: () {
                      FavoriteService.removeFavorite(d);
                      setState(() {});
                    },
                  ),

                /// ★ 편집모드일 때 +카드 항상 보임 (즐겨찾기가 없어도)
                if (_editMode)
                  AddFavoriteCard(onAdd: () => _openAddFavoriteModal()),
              ],
            ),
          ),
      ],
    );
  }

  void _openAddFavoriteModal() {
    final allDevicesBox = Hive.box<AllDevice>('all_devices');
    final favoriteList = FavoriteService.getFavorites();

    // 즐겨찾기 중복 제거
    final addableDevices = allDevicesBox.values.where((d) {
      return !favoriteList.any((f) => f.name == d.name);
    }).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text("추가 가능한 제품", style: TextStyle(fontSize: 18)),
              Expanded(
                child: ListView.builder(
                  itemCount: addableDevices.length,
                  itemBuilder: (_, i) {
                    final device = addableDevices[i];
                    return ListTile(
                      leading: Icon(
                        IconData(device.iconCode, fontFamily: 'MaterialIcons'),
                      ),
                      title: Text(device.name),
                      onTap: () {
                        FavoriteService.addFavorite(
                          FavoriteDevice(
                            name: device.name,
                            iconCode: device.iconCode,
                            type: device.type,
                          ),
                        );
                        Navigator.pop(context);
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
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
            child: Image.asset('assets/images/baby.png', fit: BoxFit.contain),
          ),
          const SizedBox(height: 12),

          // 🔥 랜덤 문구 출력
          Text(
            _randomTip,
            textAlign: TextAlign.center,
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
  final VoidCallback onPressed;

  const _TipCard({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
    required this.onPressed,
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
            onPressed: onPressed,
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

class FavoriteDeviceCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String type;
  final PregnancyController controller;
  final VoidCallback onDelete;
  final bool showDelete;

  const FavoriteDeviceCard({
    super.key,
    required this.name,
    required this.icon,
    required this.type,
    required this.controller,
    required this.onDelete,
    required this.showDelete,
  });

  /// 🔥 RoutineScreen과 동일한 상태 표시 방식
  String getStatus() {
    switch (type) {
      case "aircon":
        final temp = controller.airconTargetTemp.toStringAsFixed(0);
        final strength = controller.airconWindStrength;
        final direction = controller.airconWindDirection;

        return "$temp°C · $strength ·\n$direction";

      case "aircleaner":
        String levelText(int lv) {
          switch (lv) {
            case 0:
              return "약";
            case 1:
              return "보통";
            case 2:
              return "강";
            default:
              return "-";
          }
        }

        final clean = levelText(controller.airCleanerCleanLevel);
        final booster = levelText(controller.airCleanerBoosterLevel);
        return "청정: $clean ·\n부스터: $booster";

      case "humidifier":
        final hum = controller.humidifierTargetHumidity.toStringAsFixed(0);

        String mistPercent(int level) {
          switch (level) {
            case 1:
              return "50%";
            case 2:
              return "75%";
            case 3:
              return "100%";
            default:
              return "-";
          }
        }

        final mist = mistPercent(controller.humidifierMistLevel);

        return "희망습도: $hum% ·\n분무량: $mist";

      case "robot":
        final turbo = controller.robotTurbo ? "터보" : "일반";
        return "모드: $turbo";

      default:
        return "-";
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = getStatus();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 110,
          height: 130,
          // +카드와 동일한 크기
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28),
              const SizedBox(height: 4),

              Flexible(
                child: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                status,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
                maxLines: null,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        if (showDelete)
          Positioned(
            right: 11,
            top: -0.5,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

class AddFavoriteCard extends StatelessWidget {
  final VoidCallback onAdd;

  const AddFavoriteCard({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        width: 110,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: const Center(
          child: Icon(Icons.add, size: 30, color: Colors.black87),
        ),
      ),
    );
  }
}

class TodayDiarySummaryCard extends StatefulWidget {
  const TodayDiarySummaryCard({super.key});

  @override
  State<TodayDiarySummaryCard> createState() => _TodayDiarySummaryCardState();
}

class _TodayDiarySummaryCardState extends State<TodayDiarySummaryCard> {
  final diaryBox = Hive.box("diary");

  DateTime selectedDay = DateTime.now();

  bool isEditing = false;

  final todoCtrl = TextEditingController();
  List<String> stories = [];

  @override
  void initState() {
    super.initState();
    _loadDiary();
  }

  void _loadDiary() async {
    String key = DateFormat("yyyy-MM-dd").format(selectedDay);

    // 1) 로컬 먼저 로딩 (빠른 표시)
    final diary = diaryBox.get(key, defaultValue: {});
    todoCtrl.text = diary["todo"] ?? "";

    final diaryTextLocal = diary["stories"] ?? "";
    stories = diaryTextLocal.toString().split("\n")
        .where((e) => e.trim().isNotEmpty).toList();

    setState(() {});

    // 2) 서버에서 최신 데이터 가져오기
    final serverData = await ApiService().loadCalendarData(key);

    todoCtrl.text = serverData["todo"] ?? "";
    stories = List<String>.from(serverData["stories"] ?? []);

    // 3) 다시 로컬에 반영(자동 동기화)
    diaryBox.put(key, {
      "todo": todoCtrl.text,
      "stories": stories.join("\n"),
    });

    setState(() {});
  }

  void _saveDiary() async {
    String key = DateFormat("yyyy-MM-dd").format(selectedDay);

    // 1) 로컬(Hive) 저장
    stories.removeWhere((s) => s.trim().isEmpty);
    diaryBox.put(key, {
      "todo": todoCtrl.text,
      "stories": stories.join("\n"),   // 리스트 → 문자열
    });

    // 2) 서버 저장
    await ApiService().saveCalendarData(
      writeDate: key,
      todo: todoCtrl.text,
      stories: stories,
    );

    setState(() => isEditing = false);
  }

  void _changeDay(int offset) {
    selectedDay = selectedDay.add(Duration(days: offset));
    _loadDiary();
  }

  Future<void> _pickDay() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDay,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale("ko", "KR"),
    );

    if (picked != null) {
      setState(() {
        selectedDay = picked;
      });
      _loadDiary();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: diaryBox.listenable(),
      builder: (context, box, _) {
        String key = DateFormat("yyyy-MM-dd").format(selectedDay);
        final diary = diaryBox.get(key, defaultValue: {});

        if (!isEditing) {
          todoCtrl.text = diary["todo"] ?? "";

          final diaryText = diary["stories"] ?? "";
          stories = diaryText
              .toString()
              .split('\n')
              .where((e) => e.trim().isNotEmpty)
              .toList();
        }

        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    final formattedDate =
    DateFormat("yyyy년 MM월 dd일 E요일", "ko_KR").format(selectedDay);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfffff5f7),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- 날짜 + 수정버튼 ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _changeDay(-1),
                child: const Icon(Icons.chevron_left, size: 26),
              ),

              // 날짜 버튼
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>CalendarScreen()));},
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  if (!isEditing)
                    GestureDetector(
                      onTap: () => setState(() => isEditing = true),
                      child: const Icon(Icons.edit, size: 20),
                    ),
                  if (isEditing)
                    GestureDetector(
                      onTap: _saveDiary,
                      child: const Icon(Icons.check,
                          size: 22, color: Colors.green),
                    ),

                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _changeDay(1),
                    child: const Icon(Icons.chevron_right, size: 26),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 16),

          // ---------------- 오늘 해야 할 일 ----------------
          const Text("오늘 해야 할 일",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),

          isEditing
              ? TextField(
            controller: todoCtrl,
            maxLines: 1,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          )
              : Text(todoCtrl.text.isEmpty ? "기록 없음" : todoCtrl.text,
              style: TextStyle(color: Colors.grey.shade700)),

          const SizedBox(height: 18),

          // ---------------- 오늘 이야기 ----------------
          const Text("오늘의 이야기",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),

          isEditing ? _buildEditingStories() : _buildReadStories(),
        ],
      ),
    );
  }

  // 읽기모드 UI
  Widget _buildReadStories() {
    if (stories.isEmpty) {
      return Text("기록 없음",
          style: TextStyle(color: Colors.grey.shade700));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: stories.map((s) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text("• $s",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade700)),
        );
      }).toList(),
    );
  }

  // 편집모드 UI
  Widget _buildEditingStories() {
    return Column(
      children: [
        for (int i = 0; i < stories.length; i++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: stories[i])
                    ..selection = TextSelection.fromPosition(
                      TextPosition(offset: stories[i].length),
                    ),
                  maxLines: 2,
                  onChanged: (v) => stories[i] = v,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => setState(() {
                  stories.removeAt(i);
                }),
                child:
                const Icon(Icons.remove_circle, color: Colors.red),
              ),
            ],
          ),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: () => setState(() => stories.add("")),
          child: const Row(
            children: [
              Icon(Icons.add_circle, color: Colors.blue),
              SizedBox(width: 4),
              Text("이야기 추가"),
            ],
          ),
        )
      ],
    );
  }
}


