import 'package:flutter/material.dart';

class InfoTutorial extends StatelessWidget {
  const InfoTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F5F9),

      appBar: AppBar(
        backgroundColor: const Color(0xffF3F5F9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "정보",
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //////////////////////////////////////////////////////////////////////
            /// 🔴 섹션 1 — 맞춤형 루틴 소개
            //////////////////////////////////////////////////////////////////////
            _SectionCard(
              icon: Icons.home_outlined,
              iconColor: Colors.redAccent,
              title: "맞춤형 루틴",
              description:
              "임산부는 일상의 작은 가전 조작도 종종 불편함을 느낄 수 있습니다. "
                  "집 안 온도·공기질부터 청소까지, 생활 전반의 환경을 알아서 조율해 "
                  "당신의 편안함을 높여주는 맞춤형 루틴을 제공합니다. "
                  "당신의 삶에 자연스럽게 맞춰 움직이는 스마트 케어를 경험해보세요.",
            ),

            const SizedBox(height: 24),

            //////////////////////////////////////////////////////////////////////
            /// 🔴 섹션 2 — 루틴은 어떻게 실행될까?
            //////////////////////////////////////////////////////////////////////
            _SectionCard(
              icon: Icons.home_outlined,
              iconColor: Colors.redAccent,
              title: "루틴은 어떻게 실행될까?",
              description: "",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "언제 할까요?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 시작 조건 카드
                  _ConditionCard(),

                  const SizedBox(height: 18),

                  const Text(
                    "루틴은 이런 식으로 조건을 받아 작동됩니다. 예를 들어, "
                        "실내 공기질과 관련된 가전이라면 임산부에게 적절한 온도인 "
                        "24~26℃를 벗어날 경우 가전을 작동시킵니다.",
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 행동 카드 제목
                  const Text(
                    "무엇을 할까요?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 에어컨 액션 카드
                  _ActionCard(),

                  const SizedBox(height: 16),

                  const Text(
                    "작동된 가전은 실내 온도를 적정 범위로 맞춰주어, "
                        "더욱 편안한 환경에서 지낼 수 있도록 도와줍니다.",
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            //////////////////////////////////////////////////////////////////////
            /// 🔴 섹션 3 — 나에게 맞는 루틴
            //////////////////////////////////////////////////////////////////////
            _SectionCard(
              icon: Icons.home_outlined,
              iconColor: Colors.redAccent,
              title: "나에게 더 꼭 맞는 루틴이 필요하다면?",
              description:
              "각 가전의 루틴은 수정할 수 있어요. 수정을 원하는 가전을 클릭한 후, "
                  "상단바에 있는 편집 기능을 통해 더욱 나에게 알맞는 루틴으로 "
                  "변경할 수 있습니다.",
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back,
                              size: 26, color: Colors.black87),
                          const SizedBox(width: 10),
                          const Text(
                            "에어컨",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// 오른쪽 아래 동그란 편집 버튼
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFE85C5C),  // 빨간 테두리
                            width: 3,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 28,
                          color: Colors.black54,
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////
/// 🔶 공통 섹션 카드
///////////////////////////////////////////////////////////////////////////
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final Widget? child;

  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 아이콘 + 제목
          Row(
            children: [
              Icon(icon, color: iconColor, size: 26),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          if (description.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],

          if (child != null) child!,
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////
/// 🔶 시작 조건 카드
///////////////////////////////////////////////////////////////////////////
class _ConditionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xffFFE8E8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.thermostat, color: Colors.redAccent, size: 28),
          ),
          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "시작 조건",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff7B8BA0),
                ),
              ),
              SizedBox(height: 4),
              Text(
                "실내 온도",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "24~26°C를 벗어나면",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff4A90E2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////
/// 🔶 행동 카드
///////////////////////////////////////////////////////////////////////////
class _ActionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Image.asset("assets/images/aircon.png", width: 48, height: 48),
          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "에어컨",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "온도 조절 : 24~26°C 유지",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff4A90E2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
