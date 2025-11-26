import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상태바 색이랑 자연스럽게 맞추려고 배경색 지정
      backgroundColor: const Color(0xfff4f6e9),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/lg_thinq_splash.png'),
            fit: BoxFit.cover, // 화면 꽉 채우기
          ),
        ),
      ),
    );
  }
}
