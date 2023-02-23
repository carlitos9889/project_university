import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  static const String routeName = 'newHome';

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            if (request.url.endsWith('.docx') || request.url.endsWith('.pdf')) {
              String path = '';
              if (request.url.contains('201.docx')) {
                path = 'Caso 1.docx';
              } else if (request.url.contains('203.docx')) {
                path = 'Caso 3.docx';
              } else if (request.url.contains('didactica.pdf')) {
                path = 'Guia didactica.pdf';
              } else {
                path = 'Plan docente.pdf';
              }

              if (Platform.isAndroid) {
                createNewFile(path);
              } else {
                getFileFromAsset(path).then((_) => {});
              }

              // getFileFromAsset(path).then((value) => {});
              // createNewFileInDocumentsDirectory('Teste.pdf');
              createNewFile(path);

              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');

            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      // ..loadRequest(Uri.parse('https://flutter.dev'));
      ..loadFlutterAsset('assets/www/index.html');

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curso Ofline de POO'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(
        'assets/www/viewer/files/Metacurso/Documentos/$asset',
      );
      var bytes = data.buffer.asUint8List();
      // var dir = p.getApplicationDocumentsDirectory();
      var dirAux = await p.getExternalStorageDirectory();

      File file = File("${dirAux?.path}/$asset");
      return await file.writeAsBytes(bytes);
    } catch (e) {
      throw Exception("Error al abrir el archivo");
    }
  }

  Future<File> createNewFile(String fileName) async {
    var data = await rootBundle.load(
      'assets/www/viewer/files/Metacurso/Documentos/$fileName',
    );

    var bytes = data.buffer.asUint8List();

    final customDirectory = Directory('/storage/emulated/0/Documents/File');
    if (!await customDirectory.exists()) {
      await customDirectory.create(recursive: true);
    }

    final filePath = '${customDirectory.path}/$fileName';
    final file = File(filePath);

    final fileWriting = await file.writeAsBytes(bytes);

    return fileWriting;
  }
}
