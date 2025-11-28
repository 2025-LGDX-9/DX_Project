import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("회원가입")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: '이메일')),
            TextField(decoration: InputDecoration(labelText: '비밀번호'), obscureText: true),
            TextField(decoration: InputDecoration(labelText: '이름')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('가입 완료'),
            ),
          ],
        ),
      ),
    );
  }
}
