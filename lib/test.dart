import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Anatomy3DView extends StatefulWidget {
  final String title;
  final String url;

  const Anatomy3DView({super.key, required this.title, required this.url});

  @override
  State<Anatomy3DView> createState() => _Anatomy3DViewState();
}

class _Anatomy3DViewState extends State<Anatomy3DView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // important: initialize hybrid composition manually
    PlatformWebViewControllerCreationParams params =
    const PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: WebViewWidget(controller: _controller),
    );
  }
}
