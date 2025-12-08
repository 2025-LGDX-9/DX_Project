import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const CalendarMain());
}

class CalendarMain extends StatelessWidget {
  const CalendarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard', // 피그마 폰트에 맞게 교체
        scaffoldBackgroundColor: const Color(0xFFFFF3F5),
      ),
      home: const CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime(2025, 12, 5);
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildMonthTitle(),
            const SizedBox(height: 8),
            _buildCalendar(),
            _buildBottomCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.arrow_back_ios, size: 18, color: Colors.red),
          const SizedBox(width: 4),
          const Text(
            '2025년',
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: const [
          Text(
            '12월',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) =>
            isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        headerVisible: false, // 상단 헤더는 직접 만들었으므로 제거
        calendarFormat: CalendarFormat.month,
        daysOfWeekHeight: 24,
        rowHeight: 40,
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          weekendStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: const TextStyle(fontSize: 14),
          weekendTextStyle: const TextStyle(fontSize: 14),
          outsideDaysVisible: false,
          todayDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          selectedDecoration: const BoxDecoration(
            color: Color(0xFFFF6F6F),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) {
            // 예시: 1, 2, 3, 5일에 배너 모양 표시
            if (day.month == 12 &&
                [1, 2, 3, 5].contains(day.day)) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE9B0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    day.day == 1
                        ? '초음파 검사'
                        : day.day == 2
                        ? '마트 다녀오기'
                        : day.day == 3
                        ? '•'
                        : '정기 검진일',
                    style: const TextStyle(
                      fontSize: 8,
                      color: Colors.brown,
                    ),
                  ),
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildBottomCard() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF3F5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 날짜 + 수정 아이콘 줄
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    '2025년 12월 5일 금요일',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.edit_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            // 제목 입력 칸
            // 정기 검진일 카드
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text("정기 검진일",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ),

            const SizedBox(height: 20),
            // 댓글 리스트
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _commentCard(
                    name: '세상미인',
                    text:
                    '요즘 배가 조금씩 드드러지면서 아기가 자라는 걸 몸으로 느끼고 있다. 조금만 걸어도 숨이 차고 피곤하지만, 이 모든 변화가 소중하게 느껴진다! 도대체 오늘 누가 열대 과일 사왔으면 좋겠다.',
                    isMine: true,
                  ),
                  const SizedBox(height: 8),
                  _commentCard(
                    name: '쪽빛이',
                    text:
                    '우리 아기는 엄마 닮아서 성격이 좋을 거야. 아빠 닮으면… 음… 그냥 조용히 넘어갈게.',
                    isMine: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _commentCard({
    required String name,
    required String text,
    required bool isMine,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 원형
          CircleAvatar(
            radius: 18,
            backgroundColor:
            isMine ? const Color(0xFFFFCDD2) : const Color(0xFFB3E5FC),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
          // 텍스트 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
