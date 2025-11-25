class PregnancyController {
  String? babyNickname; // 태명
  DateTime? startDate;  // 임신 시작일

  bool get isInitialized => babyNickname != null && startDate != null;

  void saveInfo({required String nickname, required DateTime start}) {
    babyNickname = nickname;
    startDate = start;
  }

  /// 현재 임신 주차 (1주부터 시작)
  int get weeks {
    if (startDate == null) return 0;
    final diff = DateTime.now().difference(startDate!);
    return (diff.inDays / 7).floor() + 1;
  }

  /// 출산 예정일 기준 D-day 문구
  String get dDayString {
    if (startDate == null) return '';
    final dueDate = startDate!.add(const Duration(days: 280)); // 40주
    final diff = dueDate.difference(DateTime.now()).inDays;
    final y = dueDate.year;
    final m = dueDate.month.toString().padLeft(2, '0');
    final d = dueDate.day.toString().padLeft(2, '0');
    return 'D-$diff  $y.$m.$d 예정';
  }
}
