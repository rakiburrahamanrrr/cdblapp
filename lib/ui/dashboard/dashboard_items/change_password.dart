import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../loading_animation.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
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
              Uri.parse('https://cdbl.com.bd/cdblapps/resetapp.php'),
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
