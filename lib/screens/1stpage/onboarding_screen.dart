import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';

class OnboardingScreen extends StatefulWidget {
  final PregnancyController controller;
  final VoidCallback onCompleted;

  const OnboardingScreen({
    super.key,
    required this.controller,
    required this.onCompleted,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameCtrl = TextEditingController();
  DateTime? _startDate;

  /// 🔥 6자리 랜덤 코드 생성 함수
  String _generateInviteCode() {
    final random = Random();
    return List.generate(6, (_) => random.nextInt(10)).join(); // 000000~999999
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      appBar: AppBar(
        title: const Text('임산부 모드 설정'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '태명을 입력해주세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              /// 태명 입력
              TextFormField(
                controller: _nicknameCtrl,
                decoration: const InputDecoration(
                  hintText: '예: 새싹이',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '태명을 입력해주세요';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              const Text(
                '임신 시작일을 알려주세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              /// 날짜 선택
              InkWell(
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now.subtract(const Duration(days: 280)),
                    lastDate: now,
                  );
                  if (picked != null) {
                    setState(() {
                      _startDate = picked;
                    });
                  }
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _startDate == null
                            ? '날짜를 선택하세요'
                            : '${_startDate!.year}.${_startDate!.month.toString().padLeft(2, '0')}.${_startDate!.day.toString().padLeft(2, '0')}',
                      ),
                      const Icon(Icons.calendar_today, size: 18),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              /// 완료 버튼
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _startDate != null) {
                      // 1) 컨트롤러 저장
                      widget.controller.saveInfo(
                        nickname: _nicknameCtrl.text.trim(),
                        start: _startDate!,
                      );

                      // 2) 랜덤 초대코드 생성
                      String inviteCode = _generateInviteCode();

                      // 3) Hive 저장
                      final box = Hive.box('onboarding');
                      box.put('nickname', _nicknameCtrl.text.trim());
                      box.put('startDate', _startDate!.toIso8601String());
                      box.put('completed', true);
                      box.put('tutorialShown', false);

                      /// 🔥 초대코드 저장
                      box.put('inviteCode', inviteCode);

                      // 4) 이전 화면으로 true 반환
                      Navigator.pop(context, true);
                    } else if (_startDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('임신 시작일을 선택해주세요')),
                      );
                    }
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '완료',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
