import 'package:flutter/material.dart';

class ThinQSplashScreen extends StatefulWidget {
  @override
  _ThinQSplashScreenState createState() => _ThinQSplashScreenState();
}

class _ThinQSplashScreenState extends State<ThinQSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 애니메이션 설정 (로고 살짝 확대)
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    // 3초 뒤 로그인 화면으로 이동
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFE6BD), // ThinQ 흰색 배경
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'images/splash.jpg', // ThinQ 로고 이미지
            // width: 120,
            // height: 120,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

