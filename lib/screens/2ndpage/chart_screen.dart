import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pregnancy_mode_app/models/energy_log.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pregnancy_mode_app/services/energy_repository.dart';

// =====================================================
// 🔵 EXTRA_INFO 파싱: "(07~08시)" → 사용시간 계산
// =====================================================
class EnergyParser {
  static double getUsageHours(String extraInfo) {
    final regex = RegExp(r'\((\d{2})~(\d{2})시\)');
    final match = regex.firstMatch(extraInfo);

    if (match == null) return 0.0;

    int start = int.parse(match.group(1)!);
    int end = int.parse(match.group(2)!);

    if (end < start) end += 24; // 22~02시 처리

    return (end - start).toDouble();
  }
}

// =====================================================
// 🔵 기기별 계산
// =====================================================
class EnergyCalculator {
  final Box<EnergyLog> box;
  EnergyCalculator(this.box);

  double totalUsageForDevice(int deviceId) {
    final logs = box.values.where((e) => e.deviceId == deviceId).toList();
    logs.sort((a, b) => a.eventTime.compareTo(b.eventTime));

    double total = 0;
    for (final log in logs) {
      total += EnergyParser.getUsageHours(log.extraInfo);
    }
    return total;
  }

  Map<int, double> getAllEnergy() {
    return {
      1: totalUsageForDevice(1),
      2: totalUsageForDevice(2),
      3: totalUsageForDevice(3),
      4: totalUsageForDevice(4),
    };
  }

  List<EnergyLog> logsForDevice(int deviceId) {
    final result =
    box.values.where((e) => e.deviceId == deviceId).toList();
    result.sort((a, b) => a.eventTime.compareTo(b.eventTime));
    return result;
  }
}

// =====================================================
// 🔵 최근 7일 요일별 사용시간 계산
// =====================================================
Map<String, double> getWeeklyUsage(List<EnergyLog> logs) {
  Map<String, double> result = {
    "월": 0, "화": 0, "수": 0, "목": 0, "금": 0, "토": 0, "일": 0,
  };

  DateTime now = DateTime.now();
  DateTime sevenDaysAgo = now.subtract(const Duration(days: 6));

  for (final log in logs) {
    if (log.eventTime.isBefore(sevenDaysAgo)) continue;

    final weekday = log.eventTime.weekday;
    final hours = EnergyParser.getUsageHours(log.extraInfo);

    switch (weekday) {
      case 1: result["월"] = result["월"]! + hours; break;
      case 2: result["화"] = result["화"]! + hours; break;
      case 3: result["수"] = result["수"]! + hours; break;
      case 4: result["목"] = result["목"]! + hours; break;
      case 5: result["금"] = result["금"]! + hours; break;
      case 6: result["토"] = result["토"]! + hours; break;
      case 7: result["일"] = result["일"]! + hours; break;
    }
  }

  return result;
}

// =====================================================
// 🔵 막대그래프 데이터 생성
// =====================================================
List<BarChartGroupData> generateWeeklyGraph(Map<String, double> weekly) {
  final keys = weekly.keys.toList();

  return List.generate(keys.length, (i) {
    return BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: weekly[keys[i]]!,
          width: 14,
        )
      ],
    );
  });
}

// =====================================================
// 🔵 소비전력(W)
// =====================================================
double getDeviceWatt(int id) {
  switch (id) {
    case 1: return 1200; // 에어컨
    case 2: return 120;  // 가습기
    case 3: return 100;  // 공기청정기
    case 4: return 80;  // 로봇청소기
    default: return 0;
  }
}

// =====================================================
// 🔵 UI 화면
// =====================================================
class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  void initState() {
    super.initState();
    final box = Hive.box<EnergyLog>('energy_logs');

    // 기존 로그 삭제
    box.clear();

    // 새 로그 생성
    EnergyRepository().fetchAndSaveLogs();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<EnergyLog>('energy_logs').listenable(),
      builder: (context, box, _) {
        final calculator = EnergyCalculator(box);
        final allEnergy = calculator.getAllEnergy();

        // 🔵 총 kWh 계산
        double totalKwh = 0;
        allEnergy.forEach((deviceId, hours) {
          totalKwh += (getDeviceWatt(deviceId) * hours) / 1000.0;
        });

        // 🔵 예상 요금
        final expectedPrice = totalKwh * 88.3;

        // 🔵 도넛 그래프용 색상
        final deviceColors = {
          1: Colors.teal,
          2: Colors.lightBlue,
          3: Colors.green,
          4: Colors.grey,
        };

        // 🔵 기기별 kWh 변환
        final deviceKwh = {
          1: (getDeviceWatt(1) * allEnergy[1]!) / 1000.0,
          2: (getDeviceWatt(2) * allEnergy[2]!) / 1000.0,
          3: (getDeviceWatt(3) * allEnergy[3]!) / 1000.0,
          4: (getDeviceWatt(4) * allEnergy[4]!) / 1000.0,
        };

        return Scaffold(
          backgroundColor: const Color(0xffeef1f5),
          appBar: AppBar(
            backgroundColor: const Color(0xffeef1f5),
            elevation: 0,
            title: const Text(
              "가전 에너지 모니터링",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                // =====================================================
                // 🔵 도넛 그래프 (기기별 색 구분 + 라벨 제거)
                // =====================================================
                SizedBox(
                  height: 240,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 80,
                          sections: [
                            for (int id in deviceKwh.keys)
                              PieChartSectionData(
                                value: deviceKwh[id],
                                color: deviceColors[id],
                                radius: 22,
                                showTitle: false,
                              ),
                          ],
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "총 사용량",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "${totalKwh.toStringAsFixed(1)} kWh",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${expectedPrice.toStringAsFixed(0)}원",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // =====================================================
                // 🔵 각 기기별 통계 카드
                // =====================================================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    children: [
                      buildItem(
                        deviceId: 1,
                        name: "에어컨",
                        color: Colors.teal,
                        energy: allEnergy[1]!,
                        logs: calculator.logsForDevice(1),
                      ),
                      const SizedBox(height: 16),

                      buildItem(
                        deviceId: 2,
                        name: "가습기",
                        color: Colors.lightBlue,
                        energy: allEnergy[2]!,
                        logs: calculator.logsForDevice(2),
                      ),
                      const SizedBox(height: 16),

                      buildItem(
                        deviceId: 3,
                        name: "공기청정기",
                        color: Colors.green,
                        energy: allEnergy[3]!,
                        logs: calculator.logsForDevice(3),
                      ),
                      const SizedBox(height: 16),

                      buildItem(
                        deviceId: 4,
                        name: "로봇청소기",
                        color: Colors.grey,
                        energy: allEnergy[4]!,
                        logs: calculator.logsForDevice(4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // 🔵 개별 카드 UI
  // =========================================================
  Widget buildItem({
    required int deviceId,
    required String name,
    required Color color,
    required double energy,
    required List<EnergyLog> logs,
  }) {
    final weekly = getWeeklyUsage(logs);
    final weekKeys = weekly.keys.toList();
    final kwh = (getDeviceWatt(deviceId) * energy) / 1000.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 14, height: 14, color: color),
            const SizedBox(width: 8),
            Text(name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const Spacer(),
            Text("${energy.toStringAsFixed(1)}h"),
            const SizedBox(width: 12),
            Text("${kwh.toStringAsFixed(2)}kWh"),
          ],
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 150,
          child: BarChart(
            BarChartData(
              barGroups: generateWeeklyGraph(weekly),
              borderData: FlBorderData(show: false),

              titlesData: FlTitlesData(
                leftTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),

                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= weekKeys.length) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          weekKeys[index],
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
