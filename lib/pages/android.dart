// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs, depend_on_referenced_packages, invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import 'package:universidad/helpers/copy_pdf.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class AndroidWeb extends StatefulWidget {
  const AndroidWeb({Key? key, this.cookieManager}) : super(key: key);

  static String routeName = 'Home';

  final PlatformWebViewCookieManager? cookieManager;

  @override
  State<AndroidWeb> createState() => _AndroidWebState();
}

class _AndroidWebState extends State<AndroidWeb> {
  late final PlatformWebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PlatformWebViewController(
      AndroidWebViewControllerCreationParams(),
    )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setPlatformNavigationDelegate(
        PlatformNavigationDelegate(
          const PlatformNavigationDelegateCreationParams(),
        )
          ..setOnProgress((int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          })
          ..setOnPageStarted((String url) {
            debugPrint('Page started loading: $url');
          })
          ..setOnPageFinished((String url) {
            debugPrint('Page finished loading: $url');
          })
          ..setOnWebResourceError((WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          })
          ..setOnNavigationRequest((NavigationRequest request) {
            if (request.url.contains('Caso_1.docx')) {
              Helpers.copiarArchivoPDFAndroid(
                fileName: 'Caso_1.docx',
                context: context,
              );

              return NavigationDecision.prevent;
            }
            if (request.url.contains('Caso_3.docx')) {
              Helpers.copiarArchivoPDFAndroid(
                fileName: 'Caso_3.docx',
                context: context,
              );

              return NavigationDecision.prevent;
            }
            if (request.url.contains('Guia_didactica.pdf')) {
              Helpers.copiarArchivoPDFAndroid(
                fileName: 'Guia_didactica.pdf',
                context: context,
              );

              return NavigationDecision.prevent;
            }
            if (request.url.contains('Plan_docente.pdf')) {
              Helpers.copiarArchivoPDFAndroid(
                fileName: 'Plan_docente.pdf',
                context: context,
              );

              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          }),
      )
      ..addJavaScriptChannel(JavaScriptChannelParams(
        name: 'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      ))
      ..loadFlutterAsset('assets/www/index.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curso Offline POO'),
        centerTitle: false,
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          NavigationControls(webViewController: _controller),
        ],
      ),
      body: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _controller),
      ).build(context),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({Key? key, required this.webViewController})
      : super(key: key);

  final PlatformWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
