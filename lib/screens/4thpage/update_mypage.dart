import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';

import '../../services/api_service.dart';

class UpdateMyPageScreen extends StatefulWidget {
  final PregnancyController controller;

  const UpdateMyPageScreen({super.key, required this.controller});

  @override
  State<UpdateMyPageScreen> createState() => _UpdateMyPageScreenState();
}

class _UpdateMyPageScreenState extends State<UpdateMyPageScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameCtrl = TextEditingController();
  DateTime? _startDate;

  String? _uniqueKey;

  @override
  void initState() {
    super.initState();

    final box = Hive.box('pregnancyBox');

    _uniqueKey = box.get('unique_key');
    _nicknameCtrl.text = box.get('nickname', defaultValue: "");

    String? savedDate = box.get('startDate');

    if (savedDate != null) {
      _startDate = DateTime.parse(savedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      appBar: AppBar(
        title: const Text("정보 수정"),
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

              const Text("태명 수정하기",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              TextFormField(
                controller: _nicknameCtrl,
                decoration: const InputDecoration(
                  hintText: "태명을 입력해 주세요",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 32),

              const Text("임신 시작일 수정하기",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              InkWell(
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _startDate ?? now,
                    firstDate: now.subtract(const Duration(days: 280)),
                    lastDate: now,
                  );
                  if (picked != null) {
                    setState(() => _startDate = picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_startDate == null
                          ? "날짜 선택"
                          : "${_startDate!.year}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.day.toString().padLeft(2, '0')}"),
                      const Icon(Icons.calendar_today, size: 18),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _updateInfo,
                  child: const Text("수정하기", style: TextStyle(fontSize: 18)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _updateInfo() async {
    if (_nicknameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("태명을 입력해주세요")),
      );
      return; // 서버 통신하지 않음
    }

    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("임신 시작일을 선택해주세요")),
      );
      return; // 서버 통신하지 않음
    }

    if (_uniqueKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("고유키 정보를 찾을 수 없습니다.")),
      );
      return;
    }

    final formattedDate =
        "${_startDate!.year}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.day.toString().padLeft(2, '0')}";

    // ① Hive 업데이트
    final box = Hive.box('pregnancyBox');
    box.put('nickname', _nicknameCtrl.text.trim());
    box.put('startDate', formattedDate);

    // ② 서버 업데이트
    final success = await ApiService().updatePregnancyInfo(
      _uniqueKey!,
      _nicknameCtrl.text.trim(),
      formattedDate,
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("서버 업데이트 실패")),
      );
      return;
    }

    // ③ 컨트롤러 업데이트 (홈/마이페이지에서 즉시 반영)
    widget.controller.saveInfo(
      nickname: _nicknameCtrl.text.trim(),
      start: _startDate!,
      uniqueKey: _uniqueKey!,
    );

    // ④ 화면으로 "수정됨" 신호 보내기
    Navigator.pop(context, true);
  }

}
