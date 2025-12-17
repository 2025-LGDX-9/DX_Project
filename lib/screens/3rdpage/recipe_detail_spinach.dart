import 'package:flutter/material.dart';

class RecipeDetailSpinach extends StatelessWidget {
  const RecipeDetailSpinach({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        // 기본 leading 제거
        titleSpacing: 0,
        // 좌측 여백 제거
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black54),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 1), // 제목과의 간격 최소화
                Text(
                  "시금치 그라탕",
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
      body: Container(
        padding: EdgeInsets.all(13),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/spinach.png",
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      color: Colors.black.withOpacity(0.4),
                      child: Text(
                        "시금치 그라탕",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 25,
                  left: 10,
                  right: 10,
                  bottom: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "요리 재료",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "주재료",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "시금치 1/2 묶음(약 200g) 또는 냉동 시금치도 가능, 양파, 버터 1큰술, 밀가루 1큰술, 우유 200ml, 소금, 후추, 피자치즈, 해산물(선택사항) ",
                    ),
                    SizedBox(height: 5),
                    Text(
                      "조리법",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "1. 끓는 물에 굵은 소금을 약간 넣고 시금치를 살짝 데친 후, 찬물에 헹궈 물기를 꼭 짜서 제거해주세요. 물기를 제거하는 것이 중요하며, 너무 오래 데치지 않도록 주의해주세요. 데친 시금치는 먹기 좋은 크기(4~5cm 길이)로 썰어주세요.",
                    ),
                    SizedBox(height: 3),
                    Text(
                      "2. 화이트소스(베샤멜 소스) 만들기:\n팬에 버터 1큰술을 녹이고 다진 양파를 넣어 투명해질 때까지 볶아주세요.\n밀가루 1큰술을 넣고 약불에서 1~2분간 덩어리 없이 고루 볶아 루(roux)를 만들어주세요.\n우유 200ml를 조금씩 부어가며 멍울이 생기지 않게 빠르게 저어주세요. 소스가 걸쭉해질 때까지 약불에서 끓여주세요.\n소금, 후추로 간을 맞춰주세요.",
                    ),
                    SizedBox(height: 3),
                    Text(
                      "3. 재료 섞기: 완성된 화이트소스에 물기를 짠 시금치와 원하는 다른 재료(베이컨 볶은 것, 새우 등)를 넣고 잘 섞어주세요.",
                    ),
                    SizedBox(height: 3),
                    Text(
                      "4. 그라탕 굽기:\n오븐 용기에 3번의 시금치 혼합물을 담아주세요.\n그 위에 피자치즈나 다른 치즈를 듬뿍 뿌려주세요.",
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      child: Material(
                        color: Colors.transparent,              // 배경 투명
                        borderRadius: BorderRadius.circular(40), // ripple이 둥글게 따라가도록 설정
                        child: InkWell(
                          borderRadius: BorderRadius.circular(40), // ripple 적용
                          onTap: () {},
                          child: Ink(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xff428998),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Text(
                                "오븐에 전송",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
