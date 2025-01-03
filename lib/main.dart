import 'package:flutter/material.dart';
import 'package:jackpot_counter/format_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Keep Pushing the Button!',
      home: FormatPage(),
    );
  }
}
