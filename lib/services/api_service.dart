import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pregnancy_user.dart';

class ApiService {
  final String baseUrl = "http://192.168.219.245:8001";  // FastAPI 서버 주소

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

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
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

