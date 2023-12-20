import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrueFalseGame(),
    );
  }
}

class TrueFalseGame extends StatefulWidget {
  @override
  _TrueFalseGameState createState() => _TrueFalseGameState();
}

class _TrueFalseGameState extends State<TrueFalseGame> {
  List<String> statements = [
    'Flutter is a mobile UI framework.',
    'Dart is the primary programming language for Flutter.',
    'The sky is green.',
    'The earth is flat.',
    'A triangle has four sides.',
    'Mobile apps can be developed using Flutter.',
    'Java is the primary language for Flutter development.',
    'The sun is a planet.',
    'Flutter is developed by Facebook.',
    'In Flutter, widgets define the structure of the user interface.',
  ];

  int currentStatementIndex = 0;
  int score = 0;
  bool showResult = false;

  void checkAnswer(bool answer) {
    bool isCorrect = answer == (currentStatementIndex % 2 == 0);

    setState(() {
      showResult = true;
      if (isCorrect) {
        score++;
      }
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? 'Correct!' : 'Incorrect!'),
          content: Text(statements[currentStatementIndex]),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  showResult = false;
                  currentStatementIndex = (currentStatementIndex + 1) % statements.length;
                });
                Navigator.of(context).pop();
                if (currentStatementIndex == 0) {
                  showFinalScore();
                }
              },
              child: Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void showFinalScore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over!'),
          content: Text('Your final score is: $score out of ${statements.length ~/ 2}'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  currentStatementIndex = 0;
                  score = 0;
                });
                Navigator.of(context).pop();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('True/False Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statements[currentStatementIndex],
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => checkAnswer(true),
                  child: Text('True'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () => checkAnswer(false),
                  child: Text('False'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            if (showResult)
              Text(
                'Your answer is ${currentStatementIndex % 2 == 0 ? 'correct' : 'incorrect'}.',
                style: TextStyle(fontSize: 16.0),
              ),
          ],
        ),
      ),
    );
  }
}
