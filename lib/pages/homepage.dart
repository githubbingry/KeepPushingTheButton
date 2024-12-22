import 'package:flutter/material.dart';
import 'package:jackpot_counter/reusable.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormatPage(
      selectedIndex: PageNum.home.index,
      body: const Placeholder(),
    );
  }
}
