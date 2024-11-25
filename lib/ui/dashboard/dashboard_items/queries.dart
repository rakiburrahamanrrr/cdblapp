import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../loading_animation.dart';

class Queries extends StatefulWidget {
  const Queries({Key key}) : super(key: key);

  @override
  State<Queries> createState() => _QueriesState();
}

class _QueriesState extends State<Queries> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Queries',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.shade300,
          ),
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'https://cdbl.com.bd/fb.php',
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            Visibility(
              visible: isLoading,
              child: const Center(
                child: loadingAnimation(),
              ),
            )
          ]
      ),
    );
  }
}
