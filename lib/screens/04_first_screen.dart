import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ThinQ 홈")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text('에어컨'),
              subtitle: Text('상태: 꺼짐'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('공기청정기'),
              subtitle: Text('상태: 켜짐'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('가습기'),
              subtitle: Text('상태: 꺼짐'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('로봇청소기'),
              subtitle: Text('상태: 대기'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.devices), label: 'Devices'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Routine'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Page'),
        ],
        currentIndex: 0,
      ),
    );
  }
}
