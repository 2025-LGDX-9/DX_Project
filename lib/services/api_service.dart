import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/member_model.dart';
import '../models/pregnancy_user.dart';

class ApiService {
  final String baseUrl = "http://192.168.219.226:8001";  // FastAPI 서버 주소

  /// -----------------------------------------------------------------
  /// 1) 임신 정보 등록 API → 서버가 uniqueKey 생성하여 Flutter로 전달
  /// -----------------------------------------------------------------
  Future<RegisterResponse> registerPregnancyUser(PregnancyUser user) async {
    final url = Uri.parse("$baseUrl/register_pregnancy");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return RegisterResponse(
        success: true,
        uniqueKey: json["uniqueKey"],
      );
    } else {
      print("❌ 서버 오류: ${response.statusCode}");
      print("응답 내용: ${response.body}");
      return RegisterResponse(success: false, uniqueKey: null);
    }
  }

  /// -----------------------------------------------------------------
  /// 2) 고유키로 사용자 정보 조회
  /// -----------------------------------------------------------------
  Future<Map<String, dynamic>?> getPregnancyInfoByKey(String uniqueKey) async {
    final url = Uri.parse("$baseUrl/pregnancy/$uniqueKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["exists"] == true) {
        return data;
      }
      return null;
    } else {
      print("❌ 서버 오류: ${response.statusCode}");
      return null;
    }
  }

  Future<bool> updatePregnancyInfo(String uniqueKey, String nickname, String startDate) async {
    final url = Uri.parse("$baseUrl/pregnancy/update");

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "uniqueKey": uniqueKey,
        "babyNickname": nickname,
        "startDate": startDate,
      }),
    );

    return response.statusCode == 200;
  }

  /// -----------------------------------------------------------------
  /// 4) 그룹 멤버 조회
  /// -----------------------------------------------------------------
  Future<List<MemberModel>> getGroupMembers(String uniqueKey) async {
    final url = Uri.parse("$baseUrl/group/$uniqueKey/members");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      List membersJson = decoded["members"];

      return membersJson.map((e) => MemberModel.fromJson(e)).toList();
    } else {
      throw Exception("그룹 멤버 조회 실패: ${response.statusCode}");
    }
  }

  /// -----------------------------------------------------------------
  /// 5) 그룹 참여 (초대코드 입력 + 관계 선택)
  /// -----------------------------------------------------------------
  Future<Map<String, dynamic>> joinGroup({
    required String key,
    required String relation,
  }) async {
    final url = Uri.parse("$baseUrl/group/join");

    print("🔎 JOIN 요청 URL → $url");
    print("🔎 JOIN 요청 BODY → ${jsonEncode({"uniqueKey": key, "relation": relation})}");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "uniqueKey": key,
          "relation": relation,
        }),
      );

      print("🔎 JOIN 응답 코드 → ${response.statusCode}");
      print("🔎 JOIN 응답 바디 → ${response.body}");

      final decoded = jsonDecode(response.body);

      // -----------------------------
      // 성공 (statusCode == 200)
      // -----------------------------
      if (response.statusCode == 200) {
        return {
          "success": true,
          "message": "그룹에 성공적으로 참여했습니다!",
          "data": decoded   // ← 서버가 보낸 memberId, memberIndex 등을 전달
        };
      }

      // -----------------------------
      // 실패 (404, 400 등)
      // -----------------------------
      return {
        "success": false,
        "message": decoded["detail"] ?? "참여에 실패했습니다.",
      };

    } catch (e) {
      // -----------------------------
      // 네트워크 오류
      // -----------------------------
      return {
        "success": false,
        "message": "서버와 연결할 수 없습니다. 다시 시도해주세요.",
      };
    }
  }

  Future<bool> saveCalendarData({
    required String writeDate,     // "yyyy-MM-dd"
    required String todo,
    required List<String> stories,
  }) async {
    final url = Uri.parse("$baseUrl/calendar_data");

    // 여러 개의 이야기를 한 문자열로 합침 (줄바꿈 기준)
    final diaryText = stories.join("\n");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "writeDate": writeDate,
        "todoList": todo,
        "todayDiary": diaryText,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("❌ 캘린더 저장 실패: ${response.statusCode} / ${response.body}");
      return false;
    }
  }

  Future<Map<String, dynamic>> loadCalendarData(String writeDate) async {
    final url = Uri.parse("$baseUrl/calendar_data/$writeDate");

    final res = await http.get(url);

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      print("❌ 서버 로드 실패: ${res.body}");
      return {"todo": "", "stories": []};
    }
  }
}

/// FastAPI 응답을 담기 위한 모델
class RegisterResponse {
  final bool success;
  final String? uniqueKey;

  RegisterResponse({
    required this.success,
    required this.uniqueKey,
  });
}

