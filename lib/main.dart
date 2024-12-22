import 'package:flutter/material.dart';
import 'package:jackpot_counter/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Keep Pushing the Button!',
      home: HomePage(),
      // home: VersionOnePage(),
    );
  }
}
