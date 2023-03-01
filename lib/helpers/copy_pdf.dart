// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Helpers {
  static Future<void> copiarArchivoPDFAndroid({
    required String fileName,
    required BuildContext context,
  }) async {
    ByteData bytes = await rootBundle.load(
      'assets/www/viewer/files/Metacurso/Documentos/$fileName',
    );
    try {
      fileName = fileName.replaceAll('.', '.${const Uuid().v4()}.');

      await File('/storage/emulated/0/Download/$fileName').writeAsBytes(
        bytes.buffer.asUint8List(
          bytes.offsetInBytes,
          bytes.lengthInBytes,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Descargado: $fileName')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  static Future<void> copiarArchivoPDFIos({
    required String fileName,
    required BuildContext context,
  }) async {
    ByteData bytes = await rootBundle.load(
      'assets/www/viewer/files/Metacurso/Documentos/$fileName',
    );
    try {
      fileName = fileName.replaceAll('.', '.${const Uuid().v4()}.');
      final dir = await getApplicationDocumentsDirectory();

      await File('${dir.path}$fileName').writeAsBytes(
        bytes.buffer.asUint8List(
          bytes.offsetInBytes,
          bytes.lengthInBytes,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Descargado: $fileName')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
