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

  // =========================
  // 가전 제어 상태 - 가습기
  // =========================

  /// 가습기 전원 ON/OFF
  bool humidifierPower = true;

  /// 목표 습도 (%)
  double humidifierTargetHumidity = 50;

  /// 세기 모드 (약 / 표준 / 강풍 / 취침)
  String humidifierMode = '표준';

  /// 예약 시간 (시간 단위, 0이면 예약 없음)
  int humidifierReserveHours = 0;

  // =========================
  // 가전 제어 상태 - 에어컨
  // =========================

  /// 에어컨 전원 ON/OFF
  bool airconOn = false;

  /// 목표 온도 (℃)
  double airconTargetTemp = 24.0;

  /// 운전 모드 (냉방 / 제습 / 송풍 / 자동 등)
  String airconMode = '냉방';

  /// 풍량 단계 (1~3 정도로 사용)
  int airconFanLevel = 2;

  /// 에어컨 수면모드
  bool airconSleepMode = false;

  // =========================
  // 가전 제어 상태 - 로봇청소기 (나중에 쓸 예정)
  // =========================

  /// 로봇청소기 전원 ON/OFF
  bool robotOn = true;

  /// 하루 자동 청소 횟수
  int robotDailyCount = 2;

  /// 오전 청소 시간 (예: 10시)
  int robotMorningHour = 10;

  /// 오후 청소 시간 (예: 17시)
  int robotEveningHour = 17;
}
