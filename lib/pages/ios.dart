// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:universidad/helpers/copy_pdf.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class IosWeb extends StatefulWidget {
  const IosWeb({Key? key, this.cookieManager}) : super(key: key);

  final PlatformWebViewCookieManager? cookieManager;

  @override
  State<IosWeb> createState() => _IosWebState();
}

class _IosWebState extends State<IosWeb> {
  late final PlatformWebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PlatformWebViewController(
      WebKitWebViewControllerCreationParams(allowsInlineMediaPlayback: true),
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
              Helpers.copiarArchivoPDFIos(
                fileName: 'Caso_1.docx',
                context: context,
              );

              return NavigationDecision.prevent;
            }
            if (request.url.contains('Caso_3.docx')) {
              Helpers.copiarArchivoPDFIos(
                fileName: 'Caso_3.docx',
                context: context,
              );

              return NavigationDecision.prevent;
            }
            if (request.url.contains('Guia_didactica.pdf')) {
              Helpers.copiarArchivoPDFIos(
                fileName: 'Guia_didactica.pdf',
                context: context,
              );

              return NavigationDecision.prevent;
            }
            if (request.url.contains('Plan_docente.pdf')) {
              Helpers.copiarArchivoPDFIos(
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
        centerTitle: false,
        title: const Text('Curso Offline POO'),
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
