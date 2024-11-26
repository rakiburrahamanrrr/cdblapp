import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../loading_animation.dart';

class News extends StatefulWidget {
  const News({Key key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.shade300,
          ),
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: Stack(children: [
        WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..loadRequest(
              Uri.parse('https://cdbl.com.bd/newsapp.php?all'),
            ),
        ),
        Visibility(
          visible: isLoading,
          child: const Center(
            child: loadingAnimation(),
          ),
        )
      ]),
    );
  }
}
