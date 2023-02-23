import 'package:flutter/material.dart';

class AppThemes {
  static AppBarTheme get appBarTheme => const AppBarTheme(
        // toolbarHeight: 200,
        centerTitle: true,
        elevation: 5,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(20),
        //     bottomRight: Radius.circular(20),
        //   ),
        // ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      );
  static TextTheme get textTheme => TextTheme(
        titleLarge: TextStyle(
          fontSize: 40,
          color: Colors.black.withOpacity(0.9),
          fontWeight: FontWeight.w500,
        ),
        bodySmall: const TextStyle(fontSize: 20, color: Colors.white),
      );
}
