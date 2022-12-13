import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRcode Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'QRcode Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    bool isDetected = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: MobileScanner(
        allowDuplicates: true,
        onDetect: (barcode, args) {
          if (isDetected) return;
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
            return;
          }
          isDetected = true;
          final String code = barcode.rawValue!;
          debugPrint('Barcode found! $code');
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          final snackBar = SnackBar(content: Text('Barcode found! $code'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Timer(const Duration(seconds: 3), (() {
            debugPrint('Timer is over.');
            isDetected = false;
          }));
        },
      ),
    );
  }
}
