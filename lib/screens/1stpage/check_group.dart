import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pregnancy_mode_app/screens/1stpage/register_phone.dart';
import 'package:pregnancy_mode_app/services/api_service.dart';
import 'package:pregnancy_mode_app/models/member_model.dart';

final List<Color> memberColors = [
  Color(0xffFFB6C8), // 1번: 임산부
  Color(0xffA7C7FF), // 2번: 남편
  Color(0xffBDE7F6), // 3번
  Color(0xffA9F6E3), // 4번
  Color(0xffF5B1FF), // 5번
  Color(0xffFFB4B4), // 6번
];

Color getColorByIndex(int index) {
  if (index - 1 < memberColors.length) {
    return memberColors[index - 1];
  }
  return memberColors.last;
}


class CheckGroup extends StatefulWidget {
  final String groupCode; // 현재 아내의 초대코드 (그룹 기준)

  const CheckGroup({super.key, required this.groupCode});

  @override
  State<CheckGroup> createState() => _InviteMemberState();
}

class _InviteMemberState extends State<CheckGroup> {
  List<MemberModel> members = [];  // 게스트 멤버들만 저장
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    try {
      final api = ApiService();

      // FastAPI로부터 그룹 멤버 조회
      final result = await api.getGroupMembers(widget.groupCode);

      setState(() {
        members = result;   // 실제 DB 멤버들 저장
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("멤버 정보를 불러오지 못했습니다.")),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF0F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "홈 멤버 초대",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: _buildMemberCards(context),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // 멤버 카드 리스트 생성
  // --------------------------------------------------
  List<Widget> _buildMemberCards(BuildContext context) {
    List<Widget> cardList = [];

    final box = Hive.box('pregnancyBox');

    for (var m in members) {
      cardList.add(_buildMemberCard(m, index: m.memberIndex));
    }

    cardList.add(_buildAddButton(context));

    return cardList;
  }


  // --------------------------------------------------
  // 본인 카드 (새싹이맘)
  // --------------------------------------------------
  Widget _buildFixedMyselfCard() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xfff8d0d4),
          ),
          child: Center(
            child: Image(
              image: AssetImage("assets/images/guest.png"),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "새싹이맘",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // --------------------------------------------------
  // 게스트 카드 UI
  // --------------------------------------------------
  Widget _buildMemberCard(MemberModel m, {required int index}) {
    final box = Hive.box('pregnancyBox');
    final babyName = box.get('nickname', defaultValue: "아기");

    // 1) 기본 표시 텍스트는 relation
    String displayRelation = m.relation;

    // 2) memberIndex == 1 인 경우 → 태명맘
    if (m.memberIndex == 1) {
      displayRelation = "${babyName}맘";
    }

    // 3) 색상은 memberIndex 기반
    Color bgColor = getColorByIndex(m.memberIndex);

    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
          ),
          child: const Center(
            child: Image(
              image: AssetImage("assets/images/guest.png"),
            ),
          ),
        ),
        SizedBox(height: 8),

        /// ★★★ 여기! displayRelation 로 바꿔줘야 태명맘이 표시됨
        Text(
          displayRelation,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          "멤버 ${m.memberIndex}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }



  // --------------------------------------------------
  // +추가 버튼
  // --------------------------------------------------
  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RegisterPhone()),
        );
      },
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
            child: const Center(
              child: Icon(Icons.add, size: 50, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "추가",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
