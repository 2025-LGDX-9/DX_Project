import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/1stpage/tutorial_page_1.dart';
import 'package:pregnancy_mode_app/screens/1stpage/tutorial_page_2.dart';
import 'package:pregnancy_mode_app/screens/1stpage/tutorial_page_3.dart';
import 'package:pregnancy_mode_app/screens/1stpage/tutorial_page_4.dart';
import 'package:pregnancy_mode_app/screens/1stpage/tutorial_page_5.dart';
import 'package:pregnancy_mode_app/screens/1stpage/tutorial_page_6.dart';
import 'package:pregnancy_mode_app/screens/1stpage/tutorial_page_7.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: Material(
        color: Colors.black54,
        child: Center(
          child: Container(
            width: width * 0.88,
            height: height * 0.80,   // 높이 줄임
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xffFFF6EB),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              children: [
                // Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(7, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.redAccent.shade100
                            : Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 10),

                // PageView
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (i) {
                        setState(() => currentPage = i);
                      },
                      children: const [
                        TutorialPage1(),
                        TutorialPage7(),
                        TutorialPage6(),
                        TutorialPage2(),
                        TutorialPage3(),
                        TutorialPage4(),
                        TutorialPage5(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Skip Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // ★ 정상적으로 닫힘
                  },
                  child: const Text(
                    "건너뛰기",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
