import "dart:async";
import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_fortune_wheel/flutter_fortune_wheel.dart";
import "package:jackpot_counter/reusable.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  int jackpotprob = 0;
  int outcome = 0;
  bool useWheel = true;
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
        if (jackpotprob == 0) {
          jackpotprob = 1;
        } else {
          // +0.01 s.d. 0.05
          /*
          apakah hanya {0.01, 0.02, 0.03, 0.04, 0.05}
          atau include semua [0.01, 0.05] seperti 0.042069?
          */

          // scenario 1 : hanya {0.01, 0.02, 0.03, 0.04, 0.05}
          // representasikan dalam bentuk jackpotprob/100 atau jackpotprob%
          jackpotprob += (1 + Random().nextInt(5));
        }
      }
      if (jackpotprob >= 100) {
        jackpotprob = 100;
      }
    });
  }

  void _reset() {
    setState(() {
      counter = 0;
      jackpotprob = 0;
    });
  }

  //MARK: texts
  List<Widget> texts() {
    return [
      const Text(
        "Let's Go Gambling!!",
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
        "$jackpotprob%",
        style: const TextStyle(
          color: Col.darkBlue,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }

  //TODO: Make the + sign disable when its spinning then enable it when done

  //MARK: _spinTheWheel
  void _spinTheWheel() {
    setState(() {
      outcome = Random().nextInt(100);
      controller.add(outcome);
    });
  }

  //MARK: winloseFortuneItems
  List<FortuneItem> winloseFortuneItems() {
    listFortuneItem = [];
    for (var i = 0; i < jackpotprob; i++) {
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
    for (var i = 0; i < 100 - jackpotprob; i++) {
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
          "Congratulations, you got jackpot on $counter with the probability of $jackpotprob%! But are you really satisfied tho? Put it all on red now!",
          style: const TextStyle(
            color: Col.textWhite,
          ),
        ),
        backgroundColor: Col.darkBlue,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _reset();
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
              Navigator.pop(context);
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
                Navigator.pop(context);
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
        ...winloseFortuneItems(),
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
        ...winloseFortuneItems(),
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

  //MARK: alertAbout
  void alertAbout() {
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
              Navigator.pop(context);
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

  //MARK: buttonsRow1
  List<Widget> buttonsRow1() {
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _reset();
            });
          },
          tooltip: "Reset",
          backgroundColor: Col.darkBlue,
          child: const Icon(
            Icons.refresh_outlined,
            color: Col.textWhite,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _incrementCounter();
              if (counter > 10 && counter % 2 != 0) {
                _incrementJackpot();
                _spinTheWheel();
              }
            });
          },
          tooltip: "Increment",
          backgroundColor: Col.darkBlue,
          child: const Icon(
            Icons.add,
            color: Col.textWhite,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _spinTheWheel();
            });
          },
          tooltip: "Spin The Wheel",
          backgroundColor: Col.darkBlue,
          child: const Text(
            "Spin",
            style: TextStyle(color: Col.textWhite),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              useWheel = !useWheel;
            });
          },
          tooltip: "Change The Wheel",
          backgroundColor: Col.darkBlue,
          child: const Text(
            "Change",
            style: TextStyle(color: Col.textWhite),
          ),
        ),
      ),
    ];
  }

  //TODO: Make a new button to navigate to another page that add [0.01, 0.05] instead

  //MARK: buttonsRow2
  List<Widget> buttonsRow2() {
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              alertAbout();
            });
          },
          tooltip: "Information about this page",
          backgroundColor: Col.darkBlue,
          child: const Icon(
            Icons.question_mark,
            color: Col.textWhite,
          ),
        ),
      ),
    ];
  }

  //MARK: Widget build
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                ...buttonsRow1(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...buttonsRow2(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
