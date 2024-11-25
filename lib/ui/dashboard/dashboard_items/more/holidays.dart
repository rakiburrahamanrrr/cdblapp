import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../loading_animation.dart';

class Holidays extends StatefulWidget {
  const Holidays({Key key}) : super(key: key);

  @override
  State<Holidays> createState() => _HolidaysState();
}

class _HolidaysState extends State<Holidays> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List of Holidays',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.shade300,
          ),
        ),
        leading: BackButton(color: Colors.black),
      ),
      body:  Stack(children: [
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://cdbl.com.bd/hday.php',
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
      ]),
    );
  }
}