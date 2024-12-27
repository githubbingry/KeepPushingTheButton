import "dart:async";
import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_fortune_wheel/flutter_fortune_wheel.dart";
import "package:jackpot_counter/reusable.dart";

class VersionOnePage extends StatefulWidget {
  const VersionOnePage({super.key});

  @override
  State<VersionOnePage> createState() => _VersionOnePageState();
}

class _VersionOnePageState extends State<VersionOnePage> {
  int counter = 0;
  int jackpotProb = 0;
  int outcome = 0;
  bool useWheel = true;
  bool spinning = false;
  StreamController<int> controller = StreamController<int>.broadcast();
  List<FortuneItem> listFortuneItem = [];

  //MARK: _incrementCounter
  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  //MARK: _incrementJackpot
  void _incrementJackpot() {
    setState(() {
      if (counter > 10 && counter % 2 != 0) {
        if (jackpotProb == 0) {
          jackpotProb = 1;
        } else {
          // +0.01 s.d. 0.05
          /*
          apakah hanya {0.01, 0.02, 0.03, 0.04, 0.05}
          atau include semua [0.01, 0.05] seperti 0.042069?
          */

          // scenario 1 : hanya {0.01, 0.02, 0.03, 0.04, 0.05}
          // representasikan dalam bentuk jackpotProb/100 atau jackpotProb%
          jackpotProb += (1 + Random().nextInt(5));
        }
      }
      if (jackpotProb >= 100) {
        jackpotProb = 100;
      }
    });
  }

  void _reset() {
    setState(() {
      counter = 0;
      jackpotProb = 0;
    });
  }

  //MARK: texts
  List<Widget> texts() {
    return [
      const Text(
        "Let's Go Gambling!! (ver.1)",
        style: TextStyle(
          color: Col.darkBlue,
          fontSize: 30,
        ),
      ),
      const Text(
        "You have pushed the button this many times:",
        style: TextStyle(
          color: Col.darkBlue,
          fontSize: 16,
        ),
      ),
      Text(
        "$counter",
        style: const TextStyle(
          color: Col.darkBlue,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text(
        "Your Jackpot! probability:",
        style: TextStyle(
          color: Col.darkBlue,
          fontSize: 16,
        ),
      ),
      Text(
        "$jackpotProb%",
        style: const TextStyle(
          color: Col.darkBlue,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }

  //MARK: _spinTheWheel
  void _spinTheWheel() {
    setState(() {
      spinning = !spinning;
      outcome = Random().nextInt(100);
      controller.add(outcome);
    });
  }

  //MARK: winLoseFortuneItems
  List<FortuneItem> winLoseFortuneItems() {
    listFortuneItem = [];
    for (var i = 0; i < jackpotProb; i++) {
      listFortuneItem.add(
        FortuneItem(
          style: const FortuneItemStyle(
            color: Colors.green,
            borderColor: Col.darkBlue,
            borderWidth: 0,
          ),
          child: Text(
            useWheel ? "" : "Win",
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    for (var i = 0; i < 100 - jackpotProb; i++) {
      listFortuneItem.add(
        FortuneItem(
          style: const FortuneItemStyle(
            color: Colors.red,
            borderWidth: 0,
          ),
          child: Text(
            useWheel ? "" : "Lose",
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    listFortuneItem.shuffle();
    return listFortuneItem;
  }

  //MARK: alertJackpot
  void alertJackpot() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          "Jackpot!",
          style: TextStyle(
            color: Col.textWhite,
          ),
        ),
        content: Text(
          "Congratulations, you got jackpot on $counter with the probability of $jackpotProb%! But are you really satisfied tho? Put it all on red now!",
          style: const TextStyle(
            color: Col.textWhite,
          ),
        ),
        backgroundColor: Col.darkBlue,
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                spinning = !spinning;
                Navigator.of(context).pop();
                _reset();
              });
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Col.greyBlue),
            ),
            child: const Text(
              "Lets go again!",
              style: TextStyle(
                color: Col.darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //MARK: alertNotJackpot
  void alertNotJackpot() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          "Oh Dang it..",
          style: TextStyle(
            color: Col.textWhite,
          ),
        ),
        content: const Text(
          "Unlucky, try again! 99% quits before they got the gazillion dollars",
          style: TextStyle(
            color: Col.textWhite,
          ),
        ),
        backgroundColor: Col.darkBlue,
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                spinning = !spinning;
                Navigator.of(context).pop();
              });
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Col.greyBlue),
            ),
            child: const Text(
              "Never Give Up!",
              style: TextStyle(
                color: Col.darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //MARK: _checkJackpot
  void _checkJackpot() {
    if (listFortuneItem[outcome].style!.color == Colors.green) {
      alertJackpot();
    } else if (listFortuneItem[outcome].style!.color == Colors.red) {
      alertNotJackpot();
    } else {
      // ga mungkin sih ini... kan?
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Huh kok iso??!",
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Beneri!",
              ),
            ),
          ],
        ),
      );
    }
  }

  //MARK: wheel
  Widget wheel() {
    // controller = StreamController<int>();
    return FortuneWheel(
      selected: controller.stream,
      animateFirst: false,
      hapticImpact: HapticImpact.light,
      indicators: const [
        FortuneIndicator(
          alignment: Alignment.topCenter,
          child: TriangleIndicator(
            color: Col.darkBlue,
          ),
        ),
      ],
      items: [
        ...winLoseFortuneItems(),
      ],
      onFling: () {
        setState(() {
          _spinTheWheel();
        });
      },
      onAnimationEnd: () {
        setState(() {
          // print("outcome $outcome",);
          _checkJackpot();
        });
      },
    );
  }

  //MARK: fortuneBar
  Widget fortuneBar() {
    // controller = StreamController<int>();
    return FortuneBar(
      styleStrategy: const UniformStyleStrategy(
        color: Col.textWhite,
        borderColor: Col.darkBlue,
        borderWidth: 5,
      ),
      selected: controller.stream,
      animateFirst: false,
      indicators: const [
        FortuneIndicator(
          alignment: Alignment.topCenter,
          child: RectangleIndicator(
            color: Color.fromARGB(0, 0, 0, 0),
            borderColor: Col.darkBlue,
            borderWidth: 2,
          ),
        ),
      ],
      items: [
        ...winLoseFortuneItems(),
      ],
      onFling: () {
        setState(() {
          _spinTheWheel();
        });
      },
      onAnimationEnd: () {
        setState(() {
          // print("outcome $outcome",);
          _checkJackpot();
        });
      },
    );
  }

  //MARK: alertAboutVer1
  void alertAboutVer1() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "About",
          style: TextStyle(
            color: Col.textWhite,
          ),
        ),
        content: const Text(
          "This is the one with the jackpot probability that get added by {0.01, 0.02, 0.03, 0.04, 0.05}",
          style: TextStyle(
            color: Col.textWhite,
          ),
        ),
        backgroundColor: Col.darkBlue,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Col.greyBlue),
            ),
            child: const Text(
              "Got it",
              style: TextStyle(
                color: Col.darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //MARK: buttons
  List<Widget> buttons() {
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          heroTag: 0,
          onPressed: spinning
              ? null
              : () {
                  setState(() {
                    _reset();
                  });
                },
          tooltip: "Reset",
          backgroundColor: spinning ? Col.disabledDarkBlue : Col.darkBlue,
          child: Icon(
            Icons.refresh_outlined,
            color: spinning ? Col.disabledTextWhite : Col.textWhite,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          heroTag: 1,
          onPressed: spinning
              ? null
              : () {
                  setState(() {
                    _incrementCounter();
                    if (counter > 10 && counter % 2 != 0) {
                      _incrementJackpot();
                      _spinTheWheel();
                    }
                  });
                },
          tooltip: "Increment",
          backgroundColor: spinning ? Col.disabledDarkBlue : Col.darkBlue,
          child: Icon(
            Icons.add,
            color: spinning ? Col.disabledTextWhite : Col.textWhite,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          heroTag: 2,
          onPressed: spinning
              ? null
              : () {
                  setState(() {
                    _spinTheWheel();
                  });
                },
          tooltip: "Spin The Wheel",
          backgroundColor: spinning ? Col.disabledDarkBlue : Col.darkBlue,
          child: Text(
            "Spin",
            style: TextStyle(
              color: spinning ? Col.disabledTextWhite : Col.textWhite,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          heroTag: 3,
          onPressed: spinning
              ? null
              : () {
                  setState(() {
                    useWheel = !useWheel;
                  });
                },
          tooltip: "Change The Wheel",
          backgroundColor: spinning ? Col.disabledDarkBlue : Col.darkBlue,
          child: Text(
            "Change",
            style: TextStyle(
              color: spinning ? Col.disabledTextWhite : Col.textWhite,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          heroTag: 4,
          onPressed: () {
            setState(() {
              alertAboutVer1();
            });
          },
          tooltip: "About this page",
          backgroundColor: spinning ? Col.disabledDarkBlue : Col.darkBlue,
          child: Icon(
            Icons.question_mark,
            color: spinning ? Col.disabledTextWhite : Col.textWhite,
          ),
        ),
      ),
    ];
  }

  //MARK: Widget build
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...texts(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: useWheel
                  ? MediaQuery.of(context).size.width * 0.8
                  : MediaQuery.of(context).size.width * 0.2,
              child: useWheel ? wheel() : fortuneBar(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...buttons(),
            ],
          ),
        ],
      ),
    );
  }
}
