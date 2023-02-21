import 'package:flutter/material.dart';
import 'package:universidad/pages/home_page.dart';

class RouterApp {
  static Map<String, WidgetBuilder> get routes => {
        HomePage.routeName: (_) => const HomePage(),
      };
}
