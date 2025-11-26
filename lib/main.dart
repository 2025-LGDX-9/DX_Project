// main.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'routine_screen.dart';
import 'info_screen.dart';
import 'onboarding_screen.dart';
import 'pregnancy_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    // 1. 스플래시 먼저
    if (_showSplash) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    }

    // 2. 아직 태명 / 임신 시작일 입력 안 했으면 온보딩 화면
    if (!controller.isInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingScreen(
          controller: controller,
          onCompleted: () {
            // 온보딩에서 정보 저장 후 메인 화면으로 넘어가게 다시 build
            setState(() {});
          },
        ),
      );
    }

    // 3. 온보딩까지 끝났으면 메인 탭 화면
    final List<Widget> screens = [
      HomeScreen(controller: controller),      // 메인 홈
      RoutineScreen(controller: controller),   // 가전 루틴
      InfoScreen(controller: controller),      // 임신 정보
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (idx) {
            setState(() => _selectedIndex = idx);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices_other),
              label: '가전 루틴',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: '정보',
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
