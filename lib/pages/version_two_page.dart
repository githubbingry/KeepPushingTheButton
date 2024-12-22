import 'package:flutter/material.dart';
import 'package:jackpot_counter/reusable.dart';

class VersionTwoPage extends StatefulWidget {
  const VersionTwoPage({super.key});

  @override
  State<StatefulWidget> createState() => _VersionTwoPageState();
}

class _VersionTwoPageState extends State<VersionTwoPage> {
  //TODO: implement jackpot that add [0.01, 0.05]

  @override
  Widget build(BuildContext context) {
    return FormatPage(
      selectedIndex: PageNum.ver2.index,
      body: const Placeholder(),
    );
  }
}
