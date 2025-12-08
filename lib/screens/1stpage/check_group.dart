import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/1stpage/register_phone.dart';
import 'package:pregnancy_mode_app/services/api_service.dart';
import 'package:pregnancy_mode_app/models/member_model.dart';

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
      backgroundColor: const Color(0xfff5f6f7),
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

    // 1) 기본 사용자(새싹이맘)
    cardList.add(
      _buildMemberCard(
        MemberModel(
          memberId: 0,
          uniqueKey: widget.groupCode,
          memberIndex: 1,
          relation: "임산부",
        ),
        index: 1,
      ),
    );

    // 2) FastAPI로 조회된 게스트들
    for (var i = 0; i < members.length && i < 5; i++) {
      cardList.add(_buildMemberCard(members[i], index: i + 1));
    }

    // 3) 마지막에 +추가 버튼은 항상 가장 뒤로
    if (cardList.length < 6) {
      cardList.add(_buildAddButton(context));
    }

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
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.shade100,
          ),
          child: const Center(
            child: Image(
              image: AssetImage("assets/images/guest.png"),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          m.relation == "임산부"
              ? "임산부 (본인)"
              : m.relation,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        // 인덱스 표시 (옵션)
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
