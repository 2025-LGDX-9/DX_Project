import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screen/thinq_main.dart';
import 'home_screen.dart';
import 'routine_screen.dart';
import 'info_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    // 🔹 바텀 탭에 들어갈 실제 화면들 (항상 사용)
    final screens = [
      const ThinqHomeScreen(),      // 메인 홈
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
