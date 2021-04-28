import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ungnoti/utility/my_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowWebView extends StatefulWidget {
  @override
  _ShowWebViewState createState() => _ShowWebViewState();
}

class _ShowWebViewState extends State<ShowWebView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(initialUrl: MyConstant.urlWebView,),
    );
  }
}
