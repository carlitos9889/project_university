import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:universidad/pages/home_page.dart';

// ignore: must_be_immutable
class PdfViewPage extends StatefulWidget {
  const PdfViewPage(this.pathBook, {Key? key}) : super(key: key);
  final String pathBook;

  static const String routeName = 'pdf';

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  Widget build(BuildContext context) {
    final pdf = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/books/${widget.pathBook}'),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        leadingWidth: 120,
        leading: IconButton(
            icon: Row(
              children: const [
                Icon(Icons.arrow_back),
                Text('Atrás', style: TextStyle(fontSize: 20)),
              ],
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            }),
      ),
      body: PdfViewPinch(controller: pdf),
    );
  }
}
