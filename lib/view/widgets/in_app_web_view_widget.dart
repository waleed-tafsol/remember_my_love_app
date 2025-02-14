import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/assets.dart';
import 'custom_scaffold.dart';

class InAppWebViewWidget extends StatefulWidget {
  final String url;
  const InAppWebViewWidget({super.key, required this.url});
  @override
  State<InAppWebViewWidget> createState() => _InAppWebViewWidgetState();
}

class _InAppWebViewWidgetState extends State<InAppWebViewWidget> {
  InAppWebViewController? webViewController;
  bool isLoading = true;
  int progress = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if webview can go back
        if (await webViewController!.canGoBack()) {
          // Go back
          webViewController!.goBack();
          // Return false so this webview won't be popped
          return false;
        } else {
          // Let system handle back button
          return true;
        }
      },
      child: CustomScaffold(
          appBar: AppBar(),
          padding: EdgeInsets.zero,
          body: Stack(
            children: [
              InAppWebView(
                  initialUserScripts: UnmodifiableListView<UserScript>([]),
                  initialSettings: InAppWebViewSettings(
                    transparentBackground: true,
                  ),
                  initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      isLoading = true;
                      progress = 0;
                    });
                  },
                  onProgressChanged: (controller, p) {
                    setState(() {
                      isLoading = p < 100;
                      progress = p;
                    });
                  },
                  onLoadStop: (controller, url) {
                    setState(() {
                      isLoading = false;
                      progress = 0;
                    });
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    return NavigationActionPolicy.ALLOW;
                  }),
              if (isLoading)
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Image_assets.scaffold_image),
                    ),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          )),
    );
  }
}
