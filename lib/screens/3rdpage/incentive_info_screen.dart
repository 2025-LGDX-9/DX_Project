import 'package:flutter/material.dart';

class IncentiveInfoScreen extends StatelessWidget {
  const IncentiveInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  "출산 장려금",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 30, right: 15, left: 15),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffFAF0F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ExpansionTile(
                  title: Text("서울 시 정보",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                  textColor: Colors.black,            // 펼쳐졌을 때 텍스트 색
                  collapsedTextColor: Colors.black,   // 접혔을 때 텍스트 색
                  iconColor: Colors.black,            // 펼쳐졌을 때 아이콘 색
                  collapsedIconColor: Colors.black,   // 접혔을 때 아이콘 색
                  children: [
                    // 강남구
                    ExpansionTile(
                      title: Text("강남구", style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        _buildInfoRow(label: '거주요건', value: '1년', screenWidth: w),
                        _buildInfoRow(label: '첫째', value: '200', screenWidth: w),
                        _buildInfoRow(label: '둘째', value: '200', screenWidth: w),
                        _buildInfoRow(label: '셋째', value: '300', screenWidth: w),
                        _buildInfoRow(label: '넷째 이상', value: '500', screenWidth: w),
                        _buildInfoRow(label: '신청기한', value: '출생 후 1년 내', screenWidth: w),
                      ],
                    ),
                
                // 광진구
                    ExpansionTile(
                      title: Text("광진구", style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        _buildInfoRow(label: '거주요건', value: '1년', screenWidth: w),
                        _buildInfoRow(label: '첫째', value: '100', screenWidth: w),
                        _buildInfoRow(label: '둘째', value: '100', screenWidth: w),
                        _buildInfoRow(label: '셋째', value: '100', screenWidth: w),
                        _buildInfoRow(label: '넷째 이상', value: '200~300', screenWidth: w),
                        _buildInfoRow(label: '신청기한', value: '첫돌 이후 6개월 이내', screenWidth: w),
                      ],
                    ),
                
                // 구로구
                    ExpansionTile(
                      title: Text("구로구", style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        _buildInfoRow(label: '거주요건', value: '6개월', screenWidth: w),
                        _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                        _buildInfoRow(label: '둘째', value: '-', screenWidth: w),
                        _buildInfoRow(label: '셋째', value: '60', screenWidth: w),
                        _buildInfoRow(label: '넷째 이상', value: '200', screenWidth: w),
                        _buildInfoRow(label: '신청기한', value: '1년 이내', screenWidth: w),
                      ],
                    ),
                
                // 동작구
                    ExpansionTile(
                      title: Text("동작구", style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        _buildInfoRow(label: '거주요건', value: '6개월', screenWidth: w),
                        _buildInfoRow(label: '첫째', value: '30', screenWidth: w),
                        _buildInfoRow(label: '둘째', value: '50', screenWidth: w),
                        _buildInfoRow(label: '셋째', value: '100', screenWidth: w),
                        _buildInfoRow(label: '넷째 이상', value: '200', screenWidth: w),
                        _buildInfoRow(label: '신청기한', value: '1년 이내', screenWidth: w),
                      ],
                    ),
                
                // 서초구
                    ExpansionTile(
                      title: Text("서초구", style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        _buildInfoRow(label: '거주요건', value: '1년', screenWidth: w),
                        _buildInfoRow(label: '첫째', value: '30', screenWidth: w),
                        _buildInfoRow(label: '둘째', value: '50', screenWidth: w),
                        _buildInfoRow(label: '셋째', value: '100', screenWidth: w),
                        _buildInfoRow(label: '넷째 이상', value: '100', screenWidth: w),
                        _buildInfoRow(label: '신청기한', value: '1년 이내', screenWidth: w),
                      ],
                    ),
                
                // 성북구
                    ExpansionTile(
                      title: Text("성북구", style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        _buildInfoRow(label: '거주요건', value: '6개월', screenWidth: w),
                        _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                        _buildInfoRow(label: '둘째', value: '-', screenWidth: w),
                        _buildInfoRow(label: '셋째', value: '100', screenWidth: w),
                        _buildInfoRow(label: '넷째 이상', value: '150~200', screenWidth: w),
                        _buildInfoRow(label: '신청기한', value: '1년 이내', screenWidth: w),
                      ],
                    ),
                
                // 송파구
                    ExpansionTile(
                      title: Text("송파구", style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        _buildInfoRow(label: '거주요건', value: '6개월', screenWidth: w),
                        _buildInfoRow(label: '첫째', value: '20', screenWidth: w),
                        _buildInfoRow(label: '둘째', value: '40', screenWidth: w),
                        _buildInfoRow(label: '셋째', value: '50', screenWidth: w),
                        _buildInfoRow(label: '넷째 이상', value: '100~200', screenWidth: w),
                        _buildInfoRow(label: '신청기한', value: '180일 이내', screenWidth: w),
                      ],
                    ),
                
                // 용산구
                    ExpansionTile(
                      title: Text("용산구", style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        _buildInfoRow(label: '거주요건', value: '1년', screenWidth: w),
                        _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                        _buildInfoRow(label: '둘째', value: '-', screenWidth: w),
                        _buildInfoRow(label: '셋째', value: '200', screenWidth: w),
                        _buildInfoRow(label: '넷째 이상', value: '400', screenWidth: w),
                        _buildInfoRow(label: '신청기한', value: '1년 이내', screenWidth: w),
                      ],
                    ),
                
                // 중구
                    ExpansionTile(
                      title: Text("중구", style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        _buildInfoRow(label: '거주요건', value: '1년', screenWidth: w),
                        _buildInfoRow(label: '첫째', value: '100', screenWidth: w),
                        _buildInfoRow(label: '둘째', value: '200', screenWidth: w),
                        _buildInfoRow(label: '셋째', value: '300', screenWidth: w),
                        _buildInfoRow(label: '넷째 이상', value: '500~1000', screenWidth: w),
                        _buildInfoRow(label: '신청기한', value: '6개월 이내', screenWidth: w),
                      ],
                    ),
                
                  ],
                ),
            ExpansionTile(
              title: Text("부산 시 정보",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              textColor: Colors.black,            // 펼쳐졌을 때 텍스트 색
              collapsedTextColor: Colors.black,   // 접혔을 때 텍스트 색
              iconColor: Colors.black,            // 펼쳐졌을 때 아이콘 색
              collapsedIconColor: Colors.black,   // 접혔을 때 아이콘 색
              children: [
                ExpansionTile(
                  title: Text("강서구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 강서구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 금정구
                ExpansionTile(
                  title: Text("금정구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 금정구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 기장군
                ExpansionTile(
                  title: Text("기장군", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생 전 부모·출생아 모두 기장군 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '50만', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 남구
                ExpansionTile(
                  title: Text("남구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 남구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 부산진구
                ExpansionTile(
                  title: Text("부산진구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 부산진구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 북구
                ExpansionTile(
                  title: Text("북구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 북구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '(통상) 출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 사상구
                ExpansionTile(
                  title: Text("사상구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 사상구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 서구
                ExpansionTile(
                  title: Text("서구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 서구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 수영구
                ExpansionTile(
                  title: Text("수영구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생일 기준 둘째 이상, 부모 중 1명 이상 수영구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 연제구
                ExpansionTile(
                  title: Text("연제구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '기준일 현재 부모 또는 보호자·아동 모두 연제구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '구청장 규정', screenWidth: w),
                  ],
                ),
            
                // 해운대구
                ExpansionTile(
                  title: Text("해운대구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 해운대구 주민등록 또는 외국인등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text("대구 시 정보",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              textColor: Colors.black,            // 펼쳐졌을 때 텍스트 색
              collapsedTextColor: Colors.black,   // 접혔을 때 텍스트 색
              iconColor: Colors.black,            // 펼쳐졌을 때 아이콘 색
              collapsedIconColor: Colors.black,   // 접혔을 때 아이콘 색
              children: [
                ExpansionTile(
                  title: Text("군위군", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 강서구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 금정구
                ExpansionTile(
                  title: Text("달서구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 금정구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 기장군
                ExpansionTile(
                  title: Text("달성구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생 전 부모·출생아 모두 기장군 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '50만', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 남구
                ExpansionTile(
                  title: Text("동구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 남구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 부산진구
                ExpansionTile(
                  title: Text("북구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 부산진구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 북구
                ExpansionTile(
                  title: Text("서구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 북구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '(통상) 출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 사상구
                ExpansionTile(
                  title: Text("수성구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 사상구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
                ExpansionTile(
                  title: Text("중구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 사상구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text("인천 시 정보",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              textColor: Colors.black,            // 펼쳐졌을 때 텍스트 색
              collapsedTextColor: Colors.black,   // 접혔을 때 텍스트 색
              iconColor: Colors.black,            // 펼쳐졌을 때 아이콘 색
              collapsedIconColor: Colors.black,   // 접혔을 때 아이콘 색
              children: [
                ExpansionTile(
                  title: Text("강화군", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 강서구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 금정구
                ExpansionTile(
                  title: Text("계양구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 금정구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 기장군
                ExpansionTile(
                  title: Text("남동구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생 전 부모·출생아 모두 기장군 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '50만', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 남구
                ExpansionTile(
                  title: Text("동구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 남구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 부산진구
                ExpansionTile(
                  title: Text("미추홀구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 부산진구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 북구
                ExpansionTile(
                  title: Text("옹진군", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 북구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '(통상) 출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 사상구
                ExpansionTile(
                  title: Text("중구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 사상구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text("광주 시 정보",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              textColor: Colors.black,            // 펼쳐졌을 때 텍스트 색
              collapsedTextColor: Colors.black,   // 접혔을 때 텍스트 색
              iconColor: Colors.black,            // 펼쳐졌을 때 아이콘 색
              collapsedIconColor: Colors.black,   // 접혔을 때 아이콘 색
              children: [
                ExpansionTile(
                  title: Text("남구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 강서구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 금정구
                ExpansionTile(
                  title: Text("북구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 금정구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 기장군
                ExpansionTile(
                  title: Text("광산구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생 전 부모·출생아 모두 기장군 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '50만', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 남구
                ExpansionTile(
                  title: Text("서구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 남구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 부산진구
                ExpansionTile(
                  title: Text("동구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 부산진구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text("대전 시 정보",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              textColor: Colors.black,            // 펼쳐졌을 때 텍스트 색
              collapsedTextColor: Colors.black,   // 접혔을 때 텍스트 색
              iconColor: Colors.black,            // 펼쳐졌을 때 아이콘 색
              collapsedIconColor: Colors.black,   // 접혔을 때 아이콘 색
              children: [
                ExpansionTile(
                  title: Text("대덕구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 강서구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 금정구
                ExpansionTile(
                  title: Text("동구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 금정구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 기장군
                ExpansionTile(
                  title: Text("유성구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생 전 부모·출생아 모두 기장군 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '50만', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text("울산 시 정보",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              textColor: Colors.black,            // 펼쳐졌을 때 텍스트 색
              collapsedTextColor: Colors.black,   // 접혔을 때 텍스트 색
              iconColor: Colors.black,            // 펼쳐졌을 때 아이콘 색
              collapsedIconColor: Colors.black,   // 접혔을 때 아이콘 색
              children: [
                ExpansionTile(
                  title: Text("남구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모가 강서구 주민등록·거주', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
            
                // 금정구
                ExpansionTile(
                  title: Text("동구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생신고일 기준 부모 또는 보호자 금정구 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '별도 책정', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 1년 이내', screenWidth: w),
                  ],
                ),
            
                // 기장군
                ExpansionTile(
                  title: Text("북구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생 전 부모·출생아 모두 기장군 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '50만', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
                ExpansionTile(
                  title: Text("울주군", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생 전 부모·출생아 모두 기장군 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '50만', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
                ExpansionTile(
                  title: Text("중구", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    _buildInfoRow(label: '거주요건', value: '출생 전 부모·출생아 모두 기장군 주민등록', screenWidth: w),
                    _buildInfoRow(label: '첫째', value: '-', screenWidth: w),
                    _buildInfoRow(label: '둘째', value: '50만', screenWidth: w),
                    _buildInfoRow(label: '셋째', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '넷째 이상', value: '30만 × 12개월', screenWidth: w),
                    _buildInfoRow(label: '신청기한', value: '출생 후 90일 이내', screenWidth: w),
                  ],
                ),
              ],
            ),
            ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildInfoRow({
  required String label,
  required String value,
  required double screenWidth,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.0444444,
      vertical: screenWidth * 0.02,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label 고정폭
        SizedBox(
          width: screenWidth * 0.25,
          child: Text(
            label,
            style: TextStyle(color: Color(0xff888888)),
          ),
        ),

        // ★ value는 Expanded로 감싸기 (자동 줄바꿈)
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.black),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    ),
  );
}

