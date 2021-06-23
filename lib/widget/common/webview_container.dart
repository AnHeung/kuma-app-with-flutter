
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/widget/common/loading_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {

  final String url;

  @override
  WebViewContainerState createState() => WebViewContainerState();

  const WebViewContainer({this.url});
}

class WebViewContainerState extends State<WebViewContainer> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          gestureNavigationEnabled: true,
        ),
        LoadingIndicator(isVisible: isLoading,),
      ],
    );
  }
}