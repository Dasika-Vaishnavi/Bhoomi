import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends StatelessWidget {
  final String url;
  WebViewComponent({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.disabled,
        );
      }),
    );
  }
}
