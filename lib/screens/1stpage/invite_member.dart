import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/1stpage/register_phone.dart';

class InviteMember extends StatelessWidget {
  const InviteMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black54),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 1),
                Text(
                  "홈 멤버 초대",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 스크롤 가능한 콘텐츠 영역
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    // 상단 설명 문구
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "홈 멤버는 홈에 등록된 제품을 함께 쓸 수 있어요.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // 캐릭터 이미지
                    Image.asset("assets/images/invite_header.png"),
                    SizedBox(height: 20),

                    // 함께 쓸 제품
                    Text(
                      "함께 쓸 제품",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xfff2f3f5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "현재 등록된 제품이 없어요.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),

                    // 이런 것이 가능해요
                    Text(
                      "홈 멤버는 이런 것이 가능해요.",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 15),

                    // 카드 컨테이너 (3개 카드를 하나의 박스에)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // 첫 번째 카드 - 제품 작동하기
                          _buildFeatureCard(
                            iconPath: "assets/images/operator.png",
                            title: "제품 작동하기",
                            description: "홈 안의 제품을 작동할 수 있어요. 홈과 제품의 설정을 바꾸는 것도 가능해요.",
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),

                          // 두 번째 카드 - 스마트 루틴 사용하기
                          _buildFeatureCard(
                            iconPath: "assets/images/check_purple.png",
                            title: "스마트 루틴 사용하기",
                            description: "생활 패턴에 맞춰 홈에 등록된 제품을 자동으로 한번에 작동할 수 있어요.",
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),

                          // 세 번째 카드 - 서비스 이용하기
                          _buildFeatureCard(
                            iconPath: "assets/images/heart.png",
                            title: "서비스 이용하기",
                            description: "제품에 대한 다양한 서비스를 이용할 수 있어요. 고객 지원, 가전 리포트를 사용해보세요.",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),

                    // 개인정보 안내 텍스트
                    Text(
                      "내 프로필, 제품 사용 알림, 네트워크, 단말기 모델명 등의 정보가 홈 멤버에게 공유되며, 서비스를 탈퇴해도 일부 정보는 서비스 개선 목적으로 암호화되어 보관되고 활용돼요.",
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "자세한 내용: '앱 설정 > 개인정보 처리방침' 참조",
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // 하단 고정 초대하기 버튼
          Container(
            padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterPhone()));},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5A67FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "초대하기",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 기능 카드 위젯
  Widget _buildFeatureCard({
    required String iconPath,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 아이콘 이미지
          Container(
            width: 48,
            height: 48,
            margin: EdgeInsets.only(right: 14),
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
            ),
          ),
          // 텍스트 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
