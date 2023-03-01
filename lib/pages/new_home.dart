import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universidad/pages/android.dart';
import 'package:universidad/pages/ios.dart';

class NewHome extends StatelessWidget {
  const NewHome({super.key});
  static const String routeName = 'Home';

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? const AndroidWeb() : const IosWeb();
  }
}
