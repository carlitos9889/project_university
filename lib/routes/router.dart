import 'package:flutter/material.dart';
import 'package:universidad/pages/home_page.dart';
import 'package:universidad/pages/new_home.dart';

class RouterApp {
  static Map<String, WidgetBuilder> get routes => {
        HomePage.routeName: (_) => const HomePage(),
        NewHome.routeName: (_) => const NewHome(),
      };
}
