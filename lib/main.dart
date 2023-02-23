import 'package:flutter/material.dart';
import 'package:universidad/pages/new_home.dart';
import 'package:universidad/routes/router.dart';
import 'package:universidad/themes/themes_app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: NewHome.routeName,
      theme: ThemeData(
        appBarTheme: AppThemes.appBarTheme,
        textTheme: AppThemes.textTheme,
      ),
      routes: RouterApp.routes,
    );
  }
}
