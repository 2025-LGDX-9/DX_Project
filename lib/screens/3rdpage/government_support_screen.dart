import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/3rdpage/incentive_info_screen.dart';
import 'package:pregnancy_mode_app/screens/3rdpage/supoortBusiness_info_screen.dart';
import 'package:pregnancy_mode_app/screens/3rdpage/voucher_info_screen.dart';

/// 정부지원 / 복지정보 화면
class GovernmentSupportScreen extends StatelessWidget {
  const GovernmentSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        title: const Text('정부지원/복지정보'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 상단 큰 카드 (이미지 + 제목)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단 일러스트 이미지
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    'assets/images/support_main.png', // ← 여기에 너가 쓴 일러스트 파일 이름
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '정부지원 / 복지정보',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '임산부를 위한 정부 지원 제도와 복지 혜택을 한눈에 확인해보세요.',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 리스트 카드들
          _SupportItem(
            title: '출산 장려금',
            subtitle: '지자체별로 금액과 지원 기준이 달라요.',
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>IncentiveInfoScreen()));},
          ),
          const SizedBox(height: 12),
          _SupportItem(
            title: '임산부 건강관리 바우처',
            subtitle: '1인당 40만원 상당의 바우처를 제공하는 사업이에요.',
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>VoucherInfoScreen()));
            }
          ),
          const SizedBox(height: 12),
          _SupportItem(
            title: '육아용품 지원 사업',
            subtitle: '기저귀, 아기침대 등 출산 초기 필수용품을 지원해요.',
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>SupoortbusinessInfoScreen()));},
          ),

          const SizedBox(height: 20),

          // 더보기 버튼
          Center(
            child: OutlinedButton(
              onPressed: () {
                // TODO: 추후 상세 목록 더 늘리고 싶으면 여기에서 처리
              },
              style: OutlinedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: const Text('더보기 ▾'),
            ),
          ),
        ],
      ),
    );
  }
}

/// 개별 지원 항목 카드
class _SupportItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const _SupportItem({
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // 왼쪽 텍스트
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: onPressed,
            child: const Text('자세히보기'),
          ),
        ],
      ),
    );
  }
}
