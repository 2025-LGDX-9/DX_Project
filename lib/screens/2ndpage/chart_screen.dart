import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pregnancy_mode_app/models/energy_log.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pregnancy_mode_app/services/energy_repository.dart';

// =====================================================
// 🔵 EXTRA_INFO 파싱: "(07~08시)" → 1시간
// =====================================================
class EnergyParser {
  static double getUsageHours(String extraInfo) {
    final regex = RegExp(r'\((\d{2})~(\d{2})시\)');
    final match = regex.firstMatch(extraInfo);

    if (match == null) return 0.0;

    int start = int.parse(match.group(1)!);
    int end = int.parse(match.group(2)!);

    // 날짜 넘어가는 경우 (예: 22~02시)
    if (end < start) end += 24;

    return (end - start).toDouble();
  }
}

// =====================================================
// 🔵 기기별 사용량 계산 클래스
// =====================================================
class EnergyCalculator {
  final Box<EnergyLog> box;
  EnergyCalculator(this.box);

  /// 기기별 총 사용시간(kWh)
  double totalUsageForDevice(int deviceId) {
    final List<EnergyLog> logs =
    box.values.where((e) => e.deviceId == deviceId).toList();

    logs.sort((a, b) => a.eventTime.compareTo(b.eventTime));

    double total = 0.0;
    for (final log in logs) {
      total += EnergyParser.getUsageHours(log.extraInfo);
    }
    return total;
  }

  /// 모든 기기의 사용량 맵으로 리턴
  Map<int, double> getAllEnergy() {
    return {
      1: totalUsageForDevice(1),
      2: totalUsageForDevice(2),
      3: totalUsageForDevice(3),
      4: totalUsageForDevice(4),
    };
  }

  /// 기기별 로그 리스트
  List<EnergyLog> logsForDevice(int deviceId) {
    final logs = box.values.where((e) => e.deviceId == deviceId).toList();
    logs.sort((a, b) => a.eventTime.compareTo(b.eventTime));
    return logs;
  }
}

// =====================================================
// 🔵 그래프 생성 함수
// =====================================================
List<BarChartGroupData> generateGraph(List<EnergyLog> logs) {
  return List.generate(
    logs.length,
        (i) => BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: EnergyParser.getUsageHours(logs[i].extraInfo), // 실제 사용시간
          width: 6,
        )
      ],
    ),
  );
}

// =====================================================
// 🔵 UI 화면(스크린)
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
    EnergyRepository().fetchAndSaveLogs();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
      Hive.box<EnergyLog>('energy_logs').listenable(), // 데이터 갱신 자동 반영
      builder: (context, box, _) {
        print("현재 Hive 데이터: ${box.values.toList()}");
        final calculator = EnergyCalculator(box);

        final allEnergy = calculator.getAllEnergy();
        final totalEnergy =
        allEnergy.values.fold<double>(0, (a, b) => a + b); // 안전한 합산

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
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildItem(
                    name: "에어컨",
                    color: Colors.teal,
                    energy: allEnergy[1]!,
                    percent: totalEnergy == 0
                        ? 0
                        : allEnergy[1]! / totalEnergy * 100,
                    logs: calculator.logsForDevice(1),
                  ),

                  const SizedBox(height: 16),
                  buildItem(
                    name: "가습기",
                    color: Colors.lightBlue,
                    energy: allEnergy[2]!,
                    percent: totalEnergy == 0
                        ? 0
                        : allEnergy[2]! / totalEnergy * 100,
                    logs: calculator.logsForDevice(2),
                  ),

                  const SizedBox(height: 16),
                  buildItem(
                    name: "공기청정기",
                    color: Colors.green,
                    energy: allEnergy[3]!,
                    percent: totalEnergy == 0
                        ? 0
                        : allEnergy[3]! / totalEnergy * 100,
                    logs: calculator.logsForDevice(3),
                  ),

                  const SizedBox(height: 16),
                  buildItem(
                    name: "로봇청소기",
                    color: Colors.grey,
                    energy: allEnergy[4]!,
                    percent: totalEnergy == 0
                        ? 0
                        : allEnergy[4]! / totalEnergy * 100,
                    logs: calculator.logsForDevice(4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  Widget buildItem({
    required String name,
    required Color color,
    required double energy,
    required double percent,
    required List<EnergyLog> logs,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 14, height: 14, color: color),
            const SizedBox(width: 8),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text("${energy.toInt()}kWh"),
            const SizedBox(width: 12),
            Text("${percent.toStringAsFixed(0)}%"),
          ],
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 120,
          child: BarChart(
            BarChartData(
              barGroups: generateGraph(logs),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}
