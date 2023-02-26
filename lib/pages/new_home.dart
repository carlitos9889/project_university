import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:uuid/uuid.dart';
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
            // if (request.url.endsWith('.docx') || request.url.endsWith('.pdf')) {
            if (request.url.contains('Caso_1.docx')) {
              if (Platform.isAndroid) {
                createNewFile('Caso_1.docx');
              } else {
                getFileFromAsset('Caso_1.docx').then((_) => {});
              }
              return NavigationDecision.prevent;
            }
            if (request.url.contains('Caso_3.docx')) {
              if (Platform.isAndroid) {
                createNewFile('Caso_3.docx');
              } else {
                getFileFromAsset('Caso_3.docx').then((_) => {});
              }
              return NavigationDecision.prevent;
            }
            if (request.url.contains('Plan_docente.pdf')) {
              if (Platform.isAndroid) {
                createNewFile('Plan_docente.pdf');
              } else {
                getFileFromAsset('Plan_docente.pdf').then((_) => {});
              }
              return NavigationDecision.prevent;
            }
            if (request.url.contains('Guia_didactica.pdf')) {
              if (Platform.isAndroid) {
                createNewFile('Guia_didactica.pdf');
              } else {
                getFileFromAsset('Guia_didactica.pdf').then((_) => {});
              }
              return NavigationDecision.prevent;
            }
            // if (request.url.contains('201.docx')) {
            //   path = 'Caso_1.docx';
            // } else if (request.url.contains('203.docx')) {
            //   path = 'Caso_3.docx';
            // } else if (request.url.contains('didactica.pdf')) {
            //   path = 'Guia_didactica.pdf';
            // } else {
            //   path = 'Plan_docente.pdf';
            // }

            // Future.delayed(Duration(seconds: 1)).then(
            //   (value) => Fluttertoast.cancel(),
            // );

            // getFileFromAsset(path).then((value) => {});
            // createNewFileInDocumentsDirectory('Teste.pdf');

            // }
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

  Future<void> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(
        'assets/www/viewer/files/Metacurso/Documentos/$asset',
      );
      var bytes = data.buffer.asUint8List();
      var dir = await p.getApplicationDocumentsDirectory();
      // var dirAux = await p.getExternalStorageDirectory();

      File file = File("${dir.path}/$asset");
      await file.writeAsBytes(bytes);
      Fluttertoast.showToast(
        msg: '$asset Descargado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> createNewFile(String fileName) async {
    ByteData byteData = await rootBundle.load(
      'assets/www/viewer/files/Metacurso/Documentos/$fileName',
    );

    fileName = fileName.replaceFirst('.', '.${const Uuid().v4()}.');

    try {
      final file = File('/storage/emulated/0/Download/$fileName');
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
      print('Archivo $fileName creado con exito');
      Fluttertoast.showToast(
        msg: '$fileName Descargado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error al copiar archivo $fileName ${e.toString()}');
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
