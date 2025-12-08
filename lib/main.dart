import 'package:ex01/invite_member_screen.dart';
import 'package:flutter/material.dart';
import 'calendar_main.dart';
import 'calendar_tutorial.dart';
import 'invite_member.dart';
import 'invite_member_code.dart';

void main() {
  runApp(const MyApp());
} // 수업할 동안 건들지 말 것!

class MyApp extends StatelessWidget { // StatelessWidget을 상속받겠다
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // google에서 제공하고 있는 UI디자인 툴
      // apple에서 제공하는 CupertinoApp() 존재

      // home : 초기화면 설정
      home: CalendarTutorial(),
    );
  }
}