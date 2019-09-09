import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebTab extends StatefulWidget {

  @override
  State createState() => WebTabState();
}

class WebTabState extends State<WebTab> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {

    final Set gestureRecognizers = [
      Factory(() => EagerGestureRecognizer()),
    ].toSet();

    return Scaffold(
        body: WebView(
          initialUrl: "https://google.com",
          gestureRecognizers: gestureRecognizers,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (String url) {
            print("page call finished $url");
          },
          onWebViewCreated: (WebViewController webviewController) => {
            _controller.complete(webviewController)
          },
        )
    );
  }
}