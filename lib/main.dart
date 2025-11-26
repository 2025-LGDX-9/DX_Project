import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/home_screen.dart';
import 'package:pregnancy_mode_app/screens/routine_screen.dart';
import 'package:pregnancy_mode_app/screens/info_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/menu_screen.dart';

//test
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
      HomeScreen(controller: controller),      // 메인 홈
      RoutineScreen(controller: controller),   // 가전 루틴
      InfoScreen(controller: controller),      // 임신 정보
      MenuScreen(),
    ];

    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(useMaterial3: false),
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
