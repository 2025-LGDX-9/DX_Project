import 'package:flutter/material.dart';
import 'pregnancy_controller.dart';

class HumidifierControlScreen extends StatefulWidget {
  final PregnancyController controller;

  const HumidifierControlScreen({super.key, required this.controller});

  @override
  State<HumidifierControlScreen> createState() =>
      _HumidifierControlScreenState();
}

class _HumidifierControlScreenState extends State<HumidifierControlScreen> {
  // --------- 실제로 바뀌는 "설정 값"들 ---------
  bool isPowerOn = true;          // 전원 ON/OFF
  int mistLevel = 3;              // 분무량 단계 (1~3)
  int targetHumidity = 50;        // 희망 습도(%)
  bool isComfortCare = true;      // '쾌적 케어' 모드
  bool isAutoMode = true;         // 자동 / 수동
  int reservationHour = 3;        // 예약 시간 (0, 3, 6 등)
  bool isSilentMode = false;      // 조용(취침) 모드

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
          // 상단 제품/습도/온도 영역 (심플 버전)
          _buildTopStatus(),

          // 하단 제어 패널
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
                  // "가습 설정" + 전원 버튼
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

                  // 상단 2칸 (세기, 희망 습도)
                  Row(
                    children: [
                      Expanded(child: _buildStrengthCard()),
                      const SizedBox(width: 8),
                      Expanded(child: _buildTargetHumidityCard()),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 하단 3x2 작은 타일들
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.1,
                      children: [
                        // 전원 (켜짐 / 꺼짐)
                        SmallSettingTile(
                          icon: Icons.power_settings_new,
                          title: isPowerOn ? '켜짐' : '꺼짐',
                          subtitle: '전원',
                          isActive: isPowerOn,
                          onTap: () {
                            setState(() {
                              isPowerOn = !isPowerOn;
                            });
                          },
                        ),

                        // 분무량 100% / 50% 토글 예시
                        SmallSettingTile(
                          icon: Icons.opacity,
                          title: '${mistLevel * 25 + 25}%',
                          subtitle: '분무량',
                          isActive: mistLevel == 3,
                          onTap: () {
                            setState(() {
                              // 1→2→3→1 순환
                              mistLevel = mistLevel % 3 + 1;
                            });
                          },
                        ),

                        // 쾌적 케어 모드
                        SmallSettingTile(
                          icon: Icons.favorite_border,
                          title: isComfortCare ? '쾌적' : '일반',
                          subtitle: '케어',
                          isActive: isComfortCare,
                          onTap: () {
                            setState(() {
                              isComfortCare = !isComfortCare;
                            });
                          },
                        ),

                        // 자동 / 수동 모드
                        SmallSettingTile(
                          icon: Icons.autorenew,
                          title: isAutoMode ? '자동' : '수동',
                          subtitle: '모드',
                          isActive: isAutoMode,
                          onTap: () {
                            setState(() {
                              isAutoMode = !isAutoMode;
                            });
                          },
                        ),

                        // 예약 시간 (0→3→6→0)
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
                            });
                          },
                        ),

                        // 조용(취침) 모드
                        SmallSettingTile(
                          icon: Icons.nights_stay,
                          title: '조용',
                          subtitle: '취침 모드',
                          isActive: isSilentMode,
                          onTap: () {
                            setState(() {
                              isSilentMode = !isSilentMode;
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

  /// 상단 상태 영역
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 간단한 현재 상태 텍스트
          Row(
            children: [
              const Icon(Icons.opacity, size: 18),
              const SizedBox(width: 4),
              Text('실내 습도 34%  ·  설정 ${targetHumidity}%',
                  style: const TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.thermostat, size: 18),
              const SizedBox(width: 4),
              const Text('실내 온도 21°C  ·  상태 좋음',
                  style: TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                // 제품 간단한 일러스트 대신 아이콘
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

  /// 세기 카드
  Widget _buildStrengthCard() {
    String levelText;
    if (mistLevel == 1) {
      levelText = '약풍';
    } else if (mistLevel == 2) {
      levelText = '중간';
    } else {
      levelText = '강풍';
    }

    return _BigSettingCard(
      title: '세기',
      value: levelText,
      onMinus: () {
        setState(() {
          if (mistLevel > 1) mistLevel--;
        });
      },
      onPlus: () {
        setState(() {
          if (mistLevel < 3) mistLevel++;
        });
      },
    );
  }

  /// 희망 습도 카드
  Widget _buildTargetHumidityCard() {
    return _BigSettingCard(
      title: '희망 습도',
      value: '$targetHumidity%',
      onMinus: () {
        setState(() {
          if (targetHumidity > 30) targetHumidity -= 5;
        });
      },
      onPlus: () {
        setState(() {
          if (targetHumidity < 70) targetHumidity += 5;
        });
      },
    );
  }
}

/// 상단 두 개(세기 / 희망 습도) 큰 카드
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

/// 동그란 + / - 버튼
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

/// 아래 3x2 작은 타일
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
