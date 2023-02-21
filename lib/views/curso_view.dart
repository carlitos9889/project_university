import 'package:flutter/material.dart';
import 'package:universidad/widgets/card_books.dart';

class CursoView extends StatelessWidget {
  const CursoView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text('Curso', style: textTheme.titleLarge),
          const SizedBox(height: 30),
          const CardBooks(path: 'caso1.pdf', title: 'Caso 1'),
          const CardBooks(path: 'caso3.pdf', title: 'Caso 3'),
          const CardBooks(
            isWord: false,
            path: 'gd.pdf',
            title: 'Guia Didactica',
          ),
          const CardBooks(isWord: false, path: 'pd.pdf', title: 'Plan Docente'),
        ],
      ),
    );
  }
}
