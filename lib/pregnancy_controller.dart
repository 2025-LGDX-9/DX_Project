import 'package:hive/hive.dart';

class PregnancyController {
  String? babyNickname; // 태명
  DateTime? startDate;  // 임신 시작일
  String? uniqueKey;

  bool get isInitialized => babyNickname != null && startDate != null;

  void saveInfo({required String nickname, required DateTime start, required String uniqueKey}) {
    babyNickname = nickname;
    startDate = start;
    this.uniqueKey = uniqueKey;
  }

  // =========================
  // 에어컨 상태
  // =========================
  bool airconOn = false;
  double airconTargetTemp = 24.0;
  bool airconSleepMode = false;
  String airconWindStrength = "약풍";  // 약풍 / 보통 / 강풍
  String airconWindDirection = "집중"; // 와이드 / 집중 / 분리 / 좌 / 우

  // =========================
  // 공기청정기 상태
  // =========================
  bool airCleanerPowerOn = false;
  int airCleanerCleanLevel = 1;
  int airCleanerBoosterLevel = 0;
  bool airCleanerAiMode = true;
  bool airCleanerSmartCare = true;

  // =========================
  // 가습기 상태
  // =========================
  bool humidifierPowerOn = false;
  int humidifierMistLevel = 3;
  int humidifierTargetHumidity = 50;
  bool humidifierComfortCare = true;
  bool humidifierAutoMode = true;
  int humidifierReservationHour = 0;
  bool humidifierSilentMode = false;

  // =========================
  // 로봇청소기 상태
  // =========================
  bool robotPowerOn = false;
  bool robotTurbo = false;
  bool robotSmartTurbo = true;
  bool robotHasReservation = false;

  // ============================================================
  // 🔵 모든 디바이스 저장
  // ============================================================
  Future<void> saveAllDeviceSettings() async {
    final box = Hive.box('device_settings');

    // 에어컨
    box.put('airconOn', airconOn);
    box.put('airconTemp', airconTargetTemp);
    box.put('airconSleep', airconSleepMode);
    box.put('airconWindStrength', airconWindStrength);
    box.put('airconWindDirection', airconWindDirection);

    // 공기청정기
    box.put('ac_power', airCleanerPowerOn);
    box.put('ac_clean', airCleanerCleanLevel);
    box.put('ac_booster', airCleanerBoosterLevel);
    box.put('ac_ai', airCleanerAiMode);
    box.put('ac_smart', airCleanerSmartCare);

    // 가습기
    box.put('hum_power', humidifierPowerOn);
    box.put('hum_mist', humidifierMistLevel);
    box.put('hum_target', humidifierTargetHumidity);
    box.put('hum_comfort', humidifierComfortCare);
    box.put('hum_auto', humidifierAutoMode);
    box.put('hum_resv', humidifierReservationHour);
    box.put('hum_silent', humidifierSilentMode);

    // 로봇청소기
    box.put('robot_on', robotPowerOn);
    box.put('robot_turbo', robotTurbo);
    box.put('robot_smartTurbo', robotSmartTurbo);
    box.put('robot_resv', robotHasReservation);
  }

  void loadAllDeviceSettings() {
    final box = Hive.box('device_settings');

    // 에어컨
    airconOn = box.get('airconOn', defaultValue: false);
    airconTargetTemp = box.get('airconTemp', defaultValue: 24.0);
    airconSleepMode = box.get('airconSleep', defaultValue: false);
    airconWindStrength = box.get('airconWindStrength', defaultValue: "약풍");
    airconWindDirection = box.get('airconWindDirection', defaultValue: "집중");


    // 공기청정기
    airCleanerPowerOn = box.get('ac_power', defaultValue: true);
    airCleanerCleanLevel = box.get('ac_clean', defaultValue: 1);
    airCleanerBoosterLevel = box.get('ac_booster', defaultValue: 0);
    airCleanerAiMode = box.get('ac_ai', defaultValue: true);
    airCleanerSmartCare = box.get('ac_smart', defaultValue: true);

    // 가습기
    humidifierPowerOn = box.get('hum_power', defaultValue: true);
    humidifierMistLevel = box.get('hum_mist', defaultValue: 3);
    humidifierTargetHumidity = box.get('hum_target', defaultValue: 50);
    humidifierComfortCare = box.get('hum_comfort', defaultValue: true);
    humidifierAutoMode = box.get('hum_auto', defaultValue: true);
    humidifierReservationHour = box.get('hum_resv', defaultValue: 0);
    humidifierSilentMode = box.get('hum_silent', defaultValue: false);

    // 로봇청소기
    robotPowerOn = box.get('robot_on', defaultValue: true);
    robotTurbo = box.get('robot_turbo', defaultValue: false);
    robotSmartTurbo = box.get('robot_smartTurbo', defaultValue: true);
    robotHasReservation = box.get('robot_resv', defaultValue: false);
  }

  Future<void> loadSavedData() async {
    final box = Hive.box('onboarding');

    babyNickname = box.get('nickname');
    final dateString = box.get('startDate');

    if (dateString != null) {
      startDate = DateTime.parse(dateString);
    }
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
