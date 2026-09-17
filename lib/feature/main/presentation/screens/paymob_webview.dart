import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebView extends StatefulWidget {
  final String paymentKey;
  final String iframeId;

  const PaymobWebView({
    super.key,
    required this.paymentKey,
    required this.iframeId,
  });

  @override
  State<PaymobWebView> createState() => _PaymobWebViewState();
}

class _PaymobWebViewState extends State<PaymobWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    final paymentUrl =
        'https://accept.paymob.com/api/acceptance/iframes/'
        '${widget.iframeId}?payment_token=${widget.paymentKey}';

    controller = WebViewController()
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(paymentUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}