import 'package:flutter/material.dart';

class InviteMemberScreen extends StatelessWidget {
  const InviteMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈 멤버 초대'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 16),
          // 멤버 그리드
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _memberCard(
                  name: '새싹이맘',
                  color: const Color(0xFFFFC3C3),
                ),
                _memberCard(
                  name: '게스트1',
                  color: const Color(0xFFBBD9FF),
                ),
                _memberCard(
                  name: '게스트2',
                  color: const Color(0xFFFFE4B8),
                ),
                _addMemberCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 일반 멤버 카드
  static Widget _memberCard({
    required String name,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: color,
          child: Image.asset(
            'assets/baby.png', // 피그마 아바타 이미지 경로에 맞게 변경
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  // 추가 카드 (누르면 바텀시트)
  static Widget _addMemberCard(BuildContext context) {
    return InkWell(
      onTap: () => _showInviteBottomSheet(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: const Center(
              child: Icon(Icons.add, size: 32, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '추가',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // 초대코드 바텀시트
  static Future<void> _showInviteBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '멤버 추가',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pop(ctx); // 바텀시트 닫기
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InviteMemberScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.qr_code, color: Colors.amber),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          '내 코드 보기/초대 코드 입력하기',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


