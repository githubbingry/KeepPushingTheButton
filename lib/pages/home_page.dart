import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              "Home Page",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
                "Hai, Welcome to KeepPushingTheButton!, here is the opsional assignment for addtitional points in joining GDGoC UNSRI Mobile Development division as member."),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text("Here you can see 2 different version that I make :"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
                "Ver1 : The jackpot probability get added randomly in the set of {0.01, 0.02, 0.03, 0.04, 0.05}"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
                "Ver2 : The jackpot probability get added randomly in the interval of [0.01, 0.05]. For example: 0.042069"),
          ),
          Expanded(
            child: Text(""),
          ),
          Text(
            "Developed by : Fachry Ghifary",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Text(
              "Github : Githubbingry",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
