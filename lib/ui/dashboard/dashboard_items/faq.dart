import 'package:cdbl/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ',
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
              Uri.parse('https://cdbl.com.bd/faqapp.php'),
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
