import 'package:flutter/material.dart';
import 'package:jackpot_counter/pages/about_page.dart';
import 'package:jackpot_counter/pages/home_page.dart';
import 'package:jackpot_counter/pages/version_one_page.dart';
import 'package:jackpot_counter/pages/version_two_page.dart';
import 'package:jackpot_counter/reusable.dart';

class FormatPage extends StatefulWidget {
  const FormatPage({super.key});

  @override
  State<StatefulWidget> createState() => _FormatPageState();
}

class _FormatPageState extends State<FormatPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const VersionOnePage(),
    const VersionTwoPage(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Col.darkBlue,
        title: const Text(
          "Keep Pushing the Button!",
          style: TextStyle(color: Col.textWhite),
        ),
      ),
      backgroundColor: Col.greyBlue,
      body: _pages[_selectedIndex],
      floatingActionButton: null,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: Col.greyBlue,
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Col.textWhite,
              ),
              child: const Icon(
                Icons.home,
                color: Col.darkBlue,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.navigate_before,
              color: Col.greyBlue,
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Col.textWhite,
              ),
              child: const Icon(
                Icons.navigate_before,
                color: Col.darkBlue,
              ),
            ),
            label: 'Ver.1',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.navigate_next,
              color: Col.greyBlue,
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Col.textWhite,
              ),
              child: const Icon(
                Icons.navigate_next,
                color: Col.darkBlue,
              ),
            ),
            label: 'Ver.2',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.question_mark,
              color: Col.disabledTextWhite,
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Col.textWhite,
              ),
              child: const Icon(
                Icons.question_mark,
                color: Col.darkBlue,
              ),
            ),
            label: 'About',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Col.darkBlue,
        selectedFontSize: 14,
        selectedIconTheme: const IconThemeData(size: 28),
        selectedItemColor: Col.textWhite,
        unselectedItemColor: Col.greyBlue,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
