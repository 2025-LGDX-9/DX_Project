import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/3rdpage/recipe_detail_chicken.dart';
import 'package:pregnancy_mode_app/screens/3rdpage/recipe_detail_spinach.dart';

class NutritionGuideScreen extends StatefulWidget {
  const NutritionGuideScreen({super.key});

  @override
  State<NutritionGuideScreen> createState() => _NutritionGuideScreenState();
}

class _NutritionGuideScreenState extends State<NutritionGuideScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      appBar: AppBar(
        title: const Text("영양제/식단 가이드"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xfffdf5f7),
        elevation: 0,
        foregroundColor: Colors.black87,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: const Color(0xfffdf5f7),
            child: TabBar(
              controller: _tab,
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: const Color(0xff7b61ff),
                borderRadius: BorderRadius.circular(20),
              ),
              indicatorPadding: EdgeInsets.symmetric(vertical: 6),
              tabs: const [
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Tab(text: "영양제"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Tab(text: "식단 가이드"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Tab(text: "섭취 시 주의사항"),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _buildSupplementTab(),
          _buildFoodGuideTab(),
          _buildWarningTab(),
        ],
      ),
    );
  }

  // -----------------------------
  // 1) 영양제 탭
  // -----------------------------
  Widget _buildSupplementTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _nutrientCard(
          icon: Icons.eco,
          title: "엽산",
          subtitle: "하루 27mg 이상 섭취",
          description:
          "쑥갓, 시금치, 깻잎, 부추, 브로콜리, 딸기, 오렌지, 토마토, 키위, 콩, 바나나, 현미 등에 풍부",
        ),
        const SizedBox(height: 12),

        _nutrientCard(
          icon: Icons.favorite,
          title: "철분",
          subtitle: "임산부 필수 영양소",
          description:
          "태아 성장과 산모의 혈액 생성에 필수. 공복에 섭취하면 흡수율 증가",
        ),
        const SizedBox(height: 12),

        _nutrientCard(
          icon: Icons.light_mode,
          title: "비타민D",
          subtitle: "칼슘 흡수 도와줌",
          description:
          "햇빛 노출 + 식품을 통한 비타민D 섭취는 골격 형성에 중요",
        ),

        const SizedBox(height: 30),
        const Text(
          "오늘의 추천 음식",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _foodCard(
              image: "assets/images/chicken.png",
              title: "오븐 통닭 구이",
              buttonText: "레시피 보기",
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>RecipeDetailChicken()));}
            ),
            _foodCard(
              image: "assets/images/spinach.png",
              title: "시금치 그라탕",
              buttonText: "레시피 보기",
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>RecipeDetailSpinach()));}
            ),
          ],
        ),
      ],
    );
  }

  // -----------------------------
  // 2) 식단 가이드 탭
  // -----------------------------
  Widget _buildFoodGuideTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text(
          "식단 가이드",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          "임산부는 균형 잡힌 영양 섭취가 중요합니다.\n"
              "- 단백질: 매 끼니 포함\n"
              "- 칼슘: 우유, 치즈, 두부\n"
              "- 철분: 살코기, 녹황색채소\n"
              "- 수분섭취: 하루 1.5~2L\n\n"
              "과도한 당분/나트륨 섭취는 피해주세요.",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  // -----------------------------
  // 3) 섭취 주의사항 탭
  // -----------------------------
  Widget _buildWarningTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text(
          "섭취 시 주의사항",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          "- 철분과 칼슘은 같이 먹으면 흡수율이 떨어짐\n"
              "- 임산부 금기 성분(비타민A 과다 등) 주의\n"
              "- 모든 영양제는 과다 섭취 시 부작용 위험\n"
              "- 필요 시 산부인과 전문의와 상담",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  // -----------------------------
  // 공통 컴포넌트
  // -----------------------------

  Widget _nutrientCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(description),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _foodCard({
    required String image,
    required String title,
    required String buttonText,
    required VoidCallback onPressed,   // ← 추가
  }) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.asset(image, height: 120, width: 150, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: onPressed,    // ← 여기 적용
            child: Text(buttonText),
          )
        ],
      ),
    );
  }
}

