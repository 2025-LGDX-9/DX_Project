import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VoucherInfoScreen extends StatefulWidget  {
  const VoucherInfoScreen({super.key});

  @override
  State<VoucherInfoScreen> createState() => _VoucherInfoScreenState();
}

class _VoucherInfoScreenState extends State<VoucherInfoScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse("https://m.blog.naver.com/foreverjeon/223461488722"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("임산부 바우처"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
