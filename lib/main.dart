import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pregnancy_mode_app/models/all_device.dart';
import 'package:pregnancy_mode_app/screens/1stpage/thinq_main.dart';
import 'package:pregnancy_mode_app/screens/1stpage/splash_screen.dart';
import 'package:pregnancy_mode_app/screens/1stpage/home_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/routine_screen.dart';
import 'package:pregnancy_mode_app/screens/3rdpage/info_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/4thpage/menu_screen.dart';
import 'package:pregnancy_mode_app/services/api_service.dart';
import 'models/favorite_device.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteDeviceAdapter());

  await Hive.openBox<FavoriteDevice>('favorite_devices');
  await Hive.openBox('onboarding');
  Hive.registerAdapter(AllDeviceAdapter());
  await Hive.openBox<AllDevice>('all_devices');
  await Hive.openBox('device_settings');

  await Hive.openBox('pregnancyBox');
  var box = Hive.box('pregnancyBox');

  String? savedUniqueKey = box.get('unique_key');

  PregnancyController controller = PregnancyController();

  if (savedUniqueKey != null) {
    final api = ApiService();
    final info = await api.getPregnancyInfoByKey(savedUniqueKey);

    if (info != null) {
      controller.saveInfo(
        nickname: info["babyNickname"],
        start: DateTime.parse(info["startDate"]),
        uniqueKey: savedUniqueKey,
      );
    }
  }

  runApp(const PregnancyModeApp());
}

class PregnancyModeApp extends StatefulWidget {
  const PregnancyModeApp({super.key});

  @override
  State<PregnancyModeApp> createState() => _PregnancyModeAppState();
}

class _PregnancyModeAppState extends State<PregnancyModeApp> {
  final PregnancyController controller = PregnancyController();

  int _selectedIndex = 0;

  bool _pregnancyMode = false;
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();

    final box = Hive.box('onboarding');
    _pregnancyMode = box.get('pregnancyMode', defaultValue: false);

    controller.loadSavedData();
    controller.loadAllDeviceSettings();

    seedAllDevices();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _showSplash = false);
    });
  }

  void seedAllDevices() {
    final box = Hive.box<AllDevice>('all_devices');

    if (box.isEmpty) {
      final devices = [
        AllDevice(
          name: "에어컨",
          iconCode: Icons.ac_unit.codePoint,
          type: "aircon",
        ),
        AllDevice(
          name: "공기청정기",
          iconCode: Icons.air.codePoint,
          type: "aircleaner",
        ),
        AllDevice(
          name: "가습기",
          iconCode: Icons.water_drop.codePoint,
          type: "humidifier",
        ),
        AllDevice(
          name: "로봇청소기",
          iconCode: Icons.cleaning_services.codePoint,
          type: "robot",
        ),
      ];

      for (var d in devices) {
        box.add(d);
      }
    }
  }

  /// 🔥 HomeScreen에서 모드 변경 시 호출됨
  void _handlePregnancyModeChanged(bool isOn) {
    final box = Hive.box('onboarding');
    box.put('pregnancyMode', isOn); // DB 저장

    setState(() {
      _pregnancyMode = isOn; // 화면 즉시 전환
    });
  }

  Widget get _homeScreen {
    if (_pregnancyMode) {
      return HomeScreen(
        controller: controller,
        onPregnancyModeChanged: _handlePregnancyModeChanged, // ★ 추가됨
      );
    } else {
      return ThinqHomeScreen(
        controller: controller,
        onOnboardingCompleted: () {},
        onPregnancyModeChanged: _handlePregnancyModeChanged,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ThinQSplashScreen(),
      );
    }

    final screens = [
      _homeScreen,
      RoutineScreen(controller: controller),
      InfoScreen(controller: controller),
      MenuScreen(controller: controller,),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(child: screens[_selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: (idx) => setState(() => _selectedIndex = idx),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: "디바이스"),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: '정보'),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: '메뉴'),
          ],
        ),
      ),
    );
  }
}
