import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jackpot_counter/reusable.dart';

class VersionTwoPage extends StatefulWidget {
  const VersionTwoPage({super.key});

  @override
  State<StatefulWidget> createState() => _VersionTwoPageState();
}

class _VersionTwoPageState extends State<VersionTwoPage> {
  //TODO: implement jackpot that add [0.01, 0.05]
  double rngDouble() {
    return 0.01 + Random().nextDouble() * (0.05 - 0.01);
  }

  bool rngBool(double rates) {
    return Random().nextDouble() <= rates;
  }

  @override
  Widget build(BuildContext context) {
    return FormatPage(
      selectedIndex: PageNum.ver2.index,
      body: const Placeholder(),
    );
  }
}
