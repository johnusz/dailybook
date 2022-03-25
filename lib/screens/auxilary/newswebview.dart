import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';


class YourWebView extends StatelessWidget {
  String url;
  String title;
  YourWebView(this.url, this.title);

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(title, overflow: TextOverflow.fade),
          backgroundColor: Colors.grey[900],
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            gestureNavigationEnabled: true,
          );
        }));
  }
}