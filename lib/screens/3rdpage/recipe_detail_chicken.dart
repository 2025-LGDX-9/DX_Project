import 'package:flutter/material.dart';

class RecipeDetailChicken extends StatelessWidget {
  const RecipeDetailChicken({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false, // 기본 leading 제거
        titleSpacing: 0, // 좌측 여백 제거
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black54,),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 1), // 제목과의 간격 최소화
                Text(
                  "오븐 통닭 구이",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
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
                    "assets/images/chicken.png",
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
                        "오븐 통닭 구이",
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
                padding: EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("요리 재료", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text("주재료", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text("통닭 1마리, 소금, 후추, 곁들임 야채(당근, 감자,마늘 등), 기호에 따라 타임, 로즈마리, 월계수잎을 추가"),
                    SizedBox(height: 5,),
                    Text("조리법", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    SizedBox(height: 3,),
                    Text("1. 닭을 깨끗하게 씻은 후, 물기를 말끔히 제거해 주세요."),
                    SizedBox(height: 3,),
                    Text("2. 오븐은 220ºC로 예열해 주세요."),
                    SizedBox(height: 3,),
                    Text("3. 소금과 후추를 닭의 안쪽에 먼저 적당히 뿌려주고 닭의 표면도 마찬가지로 마사지해 주세요."),
                    SizedBox(height: 3,),
                    Text("4. 야채는 소금, 후추를 뿌리고 올리브오일을 묻혀주세요."),
                    SizedBox(height: 3,),
                    Text("5. 닭의 아랫 부분이 위로 오게 닭을 넣어주고 예열된 오븐에 190ºC로 20분 정도 구워주세요."),
                    SizedBox(height: 3,),
                    Text("6. 50분 후 치킨을 뒤집고, 180도에 다시 30분을 더 구워주세요."),
                    SizedBox(height: 3,),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow,),
                        SizedBox(width: 3,),
                        Text("허니 머스타드, 양념치킨소스과 함께 먹으면 맛있어요!", style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height: 10,),
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
                    )
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
