import 'package:flutter/material.dart';
import 'package:universidad/pages/pdf_page.dart';

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

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => PdfViewPage(path),
          ),
        );
      },
      child: Card(
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
              const Icon(Icons.search, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
