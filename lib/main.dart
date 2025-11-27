import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screen/thinq_main.dart';
import 'package:pregnancy_mode_app/screens/00_splash_screen.dart';
import 'package:pregnancy_mode_app/screens/home_screen.dart';
import 'package:pregnancy_mode_app/screens/routine_screen.dart';
import 'package:pregnancy_mode_app/screens/info_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/menu_screen.dart';

void main() {
  runApp(const PregnancyModeApp());
}

/// 앱 전체를 관리하는 StatefulWidget
class PregnancyModeApp extends StatefulWidget {
  const PregnancyModeApp({super.key});

  @override
  State<PregnancyModeApp> createState() => _PregnancyModeAppState();
}

class _PregnancyModeAppState extends State<PregnancyModeApp> {
  /// 태명 / 임신 시작일 정보를 들고 있는 컨트롤러
  final PregnancyController controller = PregnancyController();

  /// 하단 네비게이션 현재 인덱스
  int _selectedIndex = 0;

  bool _onboardingDone = false;

  /// 앱 켜졌을 때 잠깐 보여줄 LG ThinQ 스플래시 표시 여부
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // 2초 동안 스플래시 보여주고 나서 온보딩/홈으로 이동
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _showSplash = false;
      });
    });
  }

  Widget get _homeScreen {
    if (_onboardingDone) {
      // 온보딩 완료 후: 임산부 홈
      return HomeScreen(controller: controller);
    } else {
      // 온보딩 전: ThinQ 홈 + 온보딩 완료 콜백 전달
      return ThinqHomeScreen(
        controller: controller,
        onOnboardingCompleted: _handleOnboardingCompleted,
      );
    }
  }

  void _handleOnboardingCompleted() {
    setState(() {
      _onboardingDone = true;
      // 탭 인덱스는 그대로 0번 유지
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 바텀 탭에 들어갈 실제 화면들 (항상 사용)
    if (_showSplash) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ThinQSplashScreen(),
      );
    }

    final screens = [
      _homeScreen,  // 메인 홈
      RoutineScreen(controller: controller),   // 가전 루틴
      InfoScreen(controller: controller),      // 임신 정보
      MenuScreen(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(child: screens[_selectedIndex],),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black, // 선택된 아이템의 아이콘 및 레이블 색상 변경
          selectedLabelStyle: TextStyle(color: Colors.black), // 선택된 아이템의 레이블 색상 변경
          currentIndex: _selectedIndex,
          onTap: (idx) {
            setState(() => _selectedIndex = idx);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: "디바이스",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: '정보',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: '메뉴',
            ),
          ],
        ),
      ),
    );
  }
}

/// LG ThinQ 스플래시 화면
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6f3cf), // 연두 배경 (원하는 색으로 바꿔도 됨)
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Image.asset(
            'assets/images/lg_thinq_splash.png', // 👉 네가 저장한 파일 이름/경로로 수정
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
