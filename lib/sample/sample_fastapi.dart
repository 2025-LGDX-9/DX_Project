import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SampleFastapi extends StatefulWidget {
  const SampleFastapi({super.key});

  @override
  State<SampleFastapi> createState() => _SampleFastapiState();
}

class _SampleFastapiState extends State<SampleFastapi> {
  final TextEditingController _getController = TextEditingController();
  final TextEditingController _postController = TextEditingController();

  Future<void> _sendGetRequest() async {
    String data = _getController.text;

    //1. 접속할 url
    String url = "http://192.168.219.245:8000/select";
    // localhost로 쓰면 안됨!!
    // 이유 : 디바이스에는 localhost가 존재
    // 컴퓨터의 localhost에 접근 --> cmd - ipconfig
    http.Response res = await http.get(Uri.parse(url));

    print(res.body); // hello
  }

  Future<void> _sendPostRequest() async {
    String data = _postController.text;

    String url = "http://192.168.219.245:8000/insert";
    //heards --> 보내줄 데이터의 타입이 json
    http.Response res = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"value": data}),
      // BaseModel 활용하여 post 데이터 받아주고 있는 중
      // BaseModel -> json으로 데이터가 와야 인식
      // --> json으로 안올 시 422에러
    );
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FastAPI 통신 테스트"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // 🟢 GET 방식 통신용 Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "GET 방식 요청",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _getController,
                        decoration: InputDecoration(
                          labelText: "GET 요청 값",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _sendGetRequest,
                        icon: const Icon(Icons.cloud_download),
                        label: const Text("데이터 보내기 (GET)"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "받은 데이터:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          "결과",
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // 🔵 POST 방식 통신용 Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "POST 방식 요청",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _postController,
                        decoration: InputDecoration(
                          labelText: "POST 요청 값",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _sendPostRequest,
                        icon: const Icon(Icons.cloud_upload),
                        label: const Text("데이터 보내기 (POST)"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          backgroundColor: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "받은 데이터:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          "결과",
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
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
