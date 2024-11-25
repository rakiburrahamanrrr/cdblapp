import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class Downloads extends StatefulWidget {
  const Downloads({Key key}) : super(key: key);

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  InAppWebViewController webView;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Downloads',
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
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse("https://cdbl.com.bd/dwnlds.php")),
              // initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  useOnDownloadStart: true,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, url) {},
              onLoadStop: (InAppWebViewController controller, url) {},
              onDownloadStart: (controller, url) async {
                final String _url_files = "$url";
                void _launchURL_files() async => await canLaunch(_url_files)
                    ? await launch(_url_files)
                    : throw 'Could not launch $_url_files';
                _launchURL_files();
              },
            ),
          ])),
    );
  }
}
