// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:universidad/views/curso_view.dart';
import 'package:universidad/views/start_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CURSO OFFLINE PROGRAMACION ORIENTADA A OBJETOS',
          maxLines: 4,
        ),
      ),
      body: PageView(
        onPageChanged: _onPageChanged,
        controller: _pageController,
        children: const [VideoApp(), CursoView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        iconSize: 35,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Curso'),
        ],
      ),
    );
  }

  void _onPageChanged(int value) {
    setState(() {
      currentPage = value;
    });
  }

  void _onTap(int value) {
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    setState(() {
      currentPage = value;
    });
  }
}
