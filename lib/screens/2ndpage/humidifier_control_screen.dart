import 'package:flutter/material.dart';
import '../../pregnancy_controller.dart';

class HumidifierControlScreen extends StatefulWidget {
  final PregnancyController controller;

  const HumidifierControlScreen({super.key, required this.controller});

  @override
  State<HumidifierControlScreen> createState() =>
      _HumidifierControlScreenState();
}

class _HumidifierControlScreenState extends State<HumidifierControlScreen> {
  late bool isPowerOn;
  late int mistLevel;
  late int targetHumidity;
  late bool isComfortCare;
  late bool isAutoMode;
  late int reservationHour;
  late bool isSilentMode;

  @override
  void initState() {
    super.initState();

    final c = widget.controller;

    isPowerOn = c.humidifierPowerOn;
    mistLevel = c.humidifierMistLevel;
    targetHumidity = c.humidifierTargetHumidity;
    isComfortCare = c.humidifierComfortCare;
    isAutoMode = c.humidifierAutoMode;
    reservationHour = c.humidifierReservationHour;
    isSilentMode = c.humidifierSilentMode;
  }

  /// 변경된 값 → controller → Hive 저장
  void _save() {
    final c = widget.controller;

    c.humidifierPowerOn = isPowerOn;
    c.humidifierMistLevel = mistLevel;
    c.humidifierTargetHumidity = targetHumidity;
    c.humidifierComfortCare = isComfortCare;
    c.humidifierAutoMode = isAutoMode;
    c.humidifierReservationHour = reservationHour;
    c.humidifierSilentMode = isSilentMode;

    c.saveAllDeviceSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fa),
      appBar: AppBar(
        title: const Text('가습기'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildTopStatus(),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '가습 설정',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            isPowerOn = !isPowerOn;
                            _save();
                          });
                        },
                        icon: Icon(
                          isPowerOn ? Icons.power_settings_new : Icons.power_off,
                          color: isPowerOn ? const Color(0xff4da3ff) : Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildStrengthCard(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildTargetHumidityCard(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.1,
                      children: [
                        SmallSettingTile(
                          icon: Icons.power_settings_new,
                          title: isPowerOn ? '켜짐' : '꺼짐',
                          subtitle: '전원',
                          isActive: isPowerOn,
                          onTap: () {},
                        ),

                        SmallSettingTile(
                          icon: Icons.opacity,
                          title: '${mistLevel * 25 + 25}%',
                          subtitle: '분무량',
                          isActive: mistLevel == 3,
                          onTap: () {
                            setState(() {
                              mistLevel = mistLevel % 3 + 1;
                              _save();
                            });
                          },
                        ),

                        SmallSettingTile(
                          icon: Icons.favorite_border,
                          title: isComfortCare ? '쾌적' : '일반',
                          subtitle: '케어',
                          isActive: isComfortCare,
                          onTap: () {
                            setState(() {
                              isComfortCare = !isComfortCare;
                              _save();
                            });
                          },
                        ),

                        SmallSettingTile(
                          icon: Icons.autorenew,
                          title: isAutoMode ? '자동' : '수동',
                          subtitle: '모드',
                          isActive: isAutoMode,
                          onTap: () {
                            setState(() {
                              isAutoMode = !isAutoMode;
                              _save();
                            });
                          },
                        ),

                        SmallSettingTile(
                          icon: Icons.timer,
                          title: reservationHour == 0
                              ? '예약 없음'
                              : '${reservationHour}시간',
                          subtitle: '예약',
                          isActive: reservationHour != 0,
                          onTap: () {
                            setState(() {
                              if (reservationHour == 0) {
                                reservationHour = 3;
                              } else if (reservationHour == 3) {
                                reservationHour = 6;
                              } else {
                                reservationHour = 0;
                              }
                              _save();
                            });
                          },
                        ),

                        SmallSettingTile(
                          icon: Icons.nights_stay,
                          title: '조용',
                          subtitle: '취침 모드',
                          isActive: isSilentMode,
                          onTap: () {
                            setState(() {
                              isSilentMode = !isSilentMode;
                              _save();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffe8f3ff), Color(0xfff7f8fa)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.opacity, size: 18),
              const SizedBox(width: 4),
              Text(
                '실내 습도 34%  ·  설정 $targetHumidity%',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.thermostat, size: 18),
              SizedBox(width: 4),
              Text('실내 온도 21°C  ·  상태 좋음',
                  style: TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                const Icon(Icons.air, size: 80, color: Color(0xff4da3ff)),
                const SizedBox(height: 8),
                Text(
                  isPowerOn ? '가습 중' : '전원 꺼짐',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '분무량: ${mistLevel * 25 + 25}% · 조용 모드: ${isSilentMode ? 'ON' : 'OFF'}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildStrengthCard() {
    String levelText =
    mistLevel == 1 ? '약풍' : mistLevel == 2 ? '중간' : '강풍';

    return _BigSettingCard(
      title: '세기',
      value: levelText,
      onMinus: () {
        setState(() {
          if (mistLevel > 1) mistLevel--;
          _save();
        });
      },
      onPlus: () {
        setState(() {
          if (mistLevel < 3) mistLevel++;
          _save();
        });
      },
    );
  }

  Widget _buildTargetHumidityCard() {
    return _BigSettingCard(
      title: '희망 습도',
      value: '$targetHumidity%',
      onMinus: () {
        setState(() {
          if (targetHumidity > 30) targetHumidity -= 5;
          _save();
        });
      },
      onPlus: () {
        setState(() {
          if (targetHumidity < 70) targetHumidity += 5;
          _save();
        });
      },
    );
  }
}

class _BigSettingCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const _BigSettingCard({
    required this.title,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff7f8fa),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  _CircleIconButton(icon: Icons.remove, onTap: onMinus),
                  const SizedBox(width: 8),
                  _CircleIconButton(icon: Icons.add, onTap: onPlus),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: const Color(0xff4da3ff)),
      ),
    );
  }
}

class SmallSettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isActive;
  final VoidCallback onTap;

  const SmallSettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xffe8f2ff) : const Color(0xfff7f8fa),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isActive ? const Color(0xff4da3ff) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                size: 18,
                color: isActive ? const Color(0xff4da3ff) : Colors.grey),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
