import 'package:flutter/material.dart';
import 'package:jackpot_counter/pages/homepage.dart';
import 'package:jackpot_counter/pages/version_one_page.dart';
import 'package:jackpot_counter/pages/version_two_page.dart';

class Col {
  static const Color greyBlue = Color.fromARGB(255, 171, 205, 239);
  static const Color darkBlue = Color.fromARGB(255, 18, 52, 86);
  static const Color disabledDarkBlue = Color.fromARGB(180, 18, 52, 86);
  static const Color disabledTextWhite = Color.fromARGB(180, 255, 255, 255);
  static const Color transparent = Color(0x00000000);
  static const Color textWhite = Colors.white;
  static const Color textBlack = Colors.black;
}

enum PageNum {
  home,
  ver1,
  ver2,
  about,
}

class FormatPage extends StatefulWidget {
  const FormatPage({
    super.key,
    required this.selectedIndex,
    required this.body,
  });

  final int selectedIndex;
  final Widget body;

  @override
  State<StatefulWidget> createState() => _FormatPageState();
}

class _FormatPageState extends State<FormatPage> {
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
      body: Center(child: widget.body),
      floatingActionButton: null,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: Col.greyBlue,
            ),
            activeIcon: Container(
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
        selectedIconTheme: const IconThemeData(size: 30),
        selectedItemColor: Col.textWhite,
        unselectedItemColor: Col.greyBlue,
        currentIndex: widget.selectedIndex,
        onTap: (int index) {
          switch (index) {
            case 0: // home
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
              break;
            case 1: // ver.1
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const VersionOnePage(),
                ),
              );
              break;
            case 2: // ver.2
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const VersionTwoPage(),
                ),
              );
              break;
            case 3: // about this app
              break;
          }
        },
      ),
    );
  }
}
