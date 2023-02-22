import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universidad/pages/pdf_page.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CardBooks extends StatelessWidget {
  const CardBooks({
    super.key,
    this.isWord = true,
    required this.title,
    required this.path,
  });
  final bool isWord;
  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 10,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 60,
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                isWord ? 'assets/images/word.png' : 'assets/images/pdf.jpg',
              ),
            ),
            // Nombre
            const SizedBox(width: 10),
            Text(title, style: textTheme.bodySmall),
            // Icono
            const Expanded(child: SizedBox()),
            IconButton(
              iconSize: 25,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PdfViewPage(path),
                  ),
                );
              },
              icon: const Icon(Icons.file_copy, color: Colors.white),
            ),
            IconButton(
              iconSize: 25,
              onPressed: () {
                download();
              },
              icon: const Icon(Icons.download, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void download() async {
    // final pdf = pw.Document();

    // final ttf = File('assets/open-sans.ttf').readAsBytesSync();

    // pdf.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Center(
    //         child: pw.Text("Hello World", style: pw.TextStyle(font: ttf)),
    //       ); // Center
    //     }));

    // final output = await getApplicationDocumentsDirectory();
    // print(output.path);
    // final file = File("${output.path}/example.pdf");
    // await file.writeAsBytes(await pdf.save());
  }
}
