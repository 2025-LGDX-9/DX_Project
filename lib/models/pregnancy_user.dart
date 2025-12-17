class PregnancyUser {
  final String babyNickname;
  final String startDate;   // yyyy-mm-dd 형태로 전달

  PregnancyUser({
    required this.babyNickname,
    required this.startDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "babyNickname": babyNickname,
      "startDate": startDate,
    };
  }
}
