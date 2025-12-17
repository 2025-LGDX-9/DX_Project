import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/1stpage/home_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/1stpage/thinq_main.dart';

class ThinQSplashScreen extends StatefulWidget {
  @override
  _ThinQSplashScreenState createState() => _ThinQSplashScreenState();
}

class _ThinQSplashScreenState extends State<ThinQSplashScreen>
    with SingleTickerProviderStateMixin {
  final PregnancyController controller = PregnancyController();
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _onboardingDone = false;

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
    if (!mounted) return;
    setState(() {
      _onboardingDone = true;
      // 탭 인덱스는 그대로 0번 유지
    });
  }

  @override
  void initState() {
    super.initState();

    // 애니메이션 설정 (로고 살짝 확대)
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    // 3초 뒤 메인 화면으로 이동 (mounted 체크 필수)
    Future.delayed(const Duration(seconds: 3), _goNext);
  }

  void _goNext() {
    if (!mounted) return; // 위젯이 이미 dispose 되었다면 아무 것도 하지 않음

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => _homeScreen),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFE6BD),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'assets/images/lg_thinq_splash.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
