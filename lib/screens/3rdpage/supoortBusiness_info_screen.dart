import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SupoortbusinessInfoScreen extends StatefulWidget {
  const SupoortbusinessInfoScreen({super.key});

  @override
  State<SupoortbusinessInfoScreen> createState() => _SupoortbusinessInfoScreenState();
}

class _SupoortbusinessInfoScreenState extends State<SupoortbusinessInfoScreen> {
  late final WebViewController controller;


  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse("https://www.mohw.go.kr/menu.es?mid=a10711020100"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("육아용품 지원 사업"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
