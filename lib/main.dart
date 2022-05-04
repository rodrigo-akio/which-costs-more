import 'package:flutter/material.dart';
import 'brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

Brain brain = Brain();

void main() {
  // shuffles itemBank on app start
  brain.shuffleList();
  brain.reset();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int score = 0;
  int totalScore = brain.getItemBankTotal();
  int highscore = 0;

  // gets highscore stored on device
  Future<int> _getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    final highscore = prefs.getInt('highscore');
    if (highscore == null) {
      return 0;
    }
    return highscore;
  }

  // resets the highscore set on device
  Future<void> _resetHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highscore', 0);
  }

  // checks if new score is higher than highscore, then updates what is stored on device
  Future<void> _updateHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();

    int storedHighScore = await _getHighScore();
    if (storedHighScore < score) {
      await prefs.setInt('highscore', score);
      storedHighScore = await _getHighScore();
    }
    setState(() {
      highscore = storedHighScore;
    });
  }

  // displays win alert (when user finishes all questions)
  void winAlert() {
    Alert(
      context: context,
      title: "YOU WON",
      desc: "You beat the game with a score of: $score/$score, congrats!",
      buttons: [
        DialogButton(
          child: const Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              brain.shuffleList();
              Navigator.pop(context);
            });
          },
          width: 120,
        )
      ],
    ).show();
  }

  // displays lose alert and current score
  void loseAlert() {
    Alert(
      context: context,
      title: "SCORE",
      desc: "You busted! Score : $score",
      buttons: [
        DialogButton(
            child: const Text(
              "Restart",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                brain.shuffleList();
                Navigator.pop(context);
              });
            },
            width: 120)
      ],
    ).show();
  }

  // determines game condition when user clicks top choice
  void topChoice() {
    if (brain.getItemPrice() >= brain.getNextItemPrice()) {
      setState(() {
        if (brain.isFinished() == true) {
          // Display winner alert
          winAlert();
          score = 0;

          // resets after the alert
          brain.reset();
        }

        // continue if not finished
        else {
          if (brain.getItemPrice() >= brain.getNextItemPrice()) {
            score++;
          }
          brain.nextItem();
        }
      });
    }
    // lose
    else {
      _updateHighScore(score);
      loseAlert();
      brain.reset();
      score = 0;
    }
  }

  // determines game condition when user clicks bottom choice
  void bottomChoice() {
    if (brain.getItemPrice() <= brain.getNextItemPrice()) {
      setState(() {
        if (brain.isFinished() == true) {
          // Display winner alert
          winAlert();
          score = 0;

          // resets after the alert
          brain.reset();
        }

        // continue if not finished
        else {
          if (brain.getItemPrice() <= brain.getNextItemPrice()) {
            score++;
          }
          brain.nextItem();
        }
      });
    }
    // lose
    else {
      loseAlert();
      brain.reset();
      score = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // update highscore on build
    _updateHighScore(score);
    return Stack(
      children: [
        // item image/title and button
        Column(
          children: [
            InkWell(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.5,
                        fit: BoxFit.cover,
                        image: NetworkImage(brain.getItemPicture()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          brain.getItemName(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  topChoice();
                  _updateHighScore(score);
                });
              },
            ),
            InkWell(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.5,
                        fit: BoxFit.cover,
                        image: NetworkImage(brain.getNextItemPicture()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          brain.getNextItemName(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  bottomChoice();
                  _updateHighScore(score);
                });
              },
            ),
          ],
        ),
        // score
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Score: $score",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
        // higscore
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "High Score: $highscore",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
