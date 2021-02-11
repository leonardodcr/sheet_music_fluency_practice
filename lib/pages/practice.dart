import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Practice extends StatefulWidget {
  @override
  _PracticeState createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  List<String> notes = [];
  Map data = {};
  int score = 0;
  int totalNotes = 0;
  String imagePath;
  bool rightAnswer;
  Random r = Random.secure();
  int best = 0;
  SharedPreferences prefs;

  Color getScoreColor() {
    if (rightAnswer == null) return Colors.black;

    return rightAnswer ? Colors.lightGreen : Colors.red;
  }

  @override
  void initState() {
    super.initState();
    loadBest();
  }

  loadBest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      best = (prefs.getInt('best') ?? 0);
    });
  }

  setBest() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    var currBest = (prefs.getInt('best') ?? 0);
    if (score > currBest) {
      await prefs.setInt('best', score);
      setState(() {
        best = score;
      });
    }
  }

  void initialize() {
    this.startNotesList();
    this.setRandomImagePath();
  }

  void startNotesList() {
    if (data['clefs'] == 'Bass') {
      notes.addAll([
        'b_g2',
        'b_a2',
        'b_b2',
        'b_c3',
        'b_d3',
        'b_e3',
        'b_f3',
        'b_g3',
        'b_a3'
      ]);

      if (data['ledgerLines'] > 0) {
        notes.addAll(['b_e2', 'b_f2', 'b_b3', 'b_c4']);
      }
      if (data['ledgerLines'] > 1) {
        notes.addAll(['b_c2', 'b_d2', 'b_d4', 'b_e4']);
      }
      if (data['ledgerLines'] > 2) {
        notes.addAll(['b_a1', 'b_b1', 'b_f4', 'b_g4']);
      }
      if (data['ledgerLines'] > 3) {
        notes.addAll(['b_f1', 'b_g1', 'b_a4', 'b_b4']);
      }
      if (data['ledgerLines'] > 4) {
        notes.addAll(['b_d1', 'b_e1', 'b_c5', 'b_d5']);
      }
    } else {
      notes.addAll([
        't_e4',
        't_f4',
        't_g4',
        't_a4',
        't_b4',
        't_c5',
        't_d5',
        't_e5',
        't_f5'
      ]);

      if (data['ledgerLines'] > 0) {
        notes.addAll(['t_c4', 't_d4', 't_g5', 't_a5']);
      }
      if (data['ledgerLines'] > 1) {
        notes.addAll(['t_a3', 't_b3', 't_b5', 't_c6']);
      }
      if (data['ledgerLines'] > 2) {
        notes.addAll(['t_f3', 't_g3', 't_d6', 't_e6']);
      }
      if (data['ledgerLines'] > 3) {
        notes.addAll(['t_d3', 't_e3', 't_f6', 't_g6']);
      }
      if (data['ledgerLines'] > 4) {
        notes.addAll(['t_b2', 't_c3', 't_a6', 't_b6']);
      }
    }
  }

  void press(String note) async {
    if (note == imagePath.substring(2, 3)) {
      setState(() {
        score++;
        setBest();
        rightAnswer = true;
        loadNextNote();
      });
    } else {
      setState(() {
        rightAnswer = false;
        loadNextNote();
      });
    }
  }

  void loadNextNote() {
    totalNotes++;
    this.setRandomImagePath();
  }

  void setRandomImagePath() {
    imagePath = notes[r.nextInt(notes.length)];
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    if (notes.isEmpty) {
      initialize();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sheet music fluency practice'),
        backgroundColor: Colors.green[800],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best: $best',
                    style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Score: $score/$totalNotes',
                    style: TextStyle(
                        fontSize: 19.0,
                        color: getScoreColor(),
                        fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset('assets/$imagePath.png', height: 225),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.orange,
                      minimumSize: Size(60, 60)),
                  onPressed: () {
                    press('c');
                  },
                  child: Text(data['notation'] == 'Classic' ? 'Dó' : 'C',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              SizedBox(width: 5),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.orange,
                      minimumSize: Size(60, 60)),
                  onPressed: () {
                    press('d');
                  },
                  child: Text(data['notation'] == 'Classic' ? 'Ré' : 'D',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              SizedBox(width: 5),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.orange,
                      minimumSize: Size(60, 60)),
                  onPressed: () {
                    press('e');
                  },
                  child: Text(data['notation'] == 'Classic' ? 'Mi' : 'E',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              SizedBox(width: 5),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.orange,
                      minimumSize: Size(60, 60)),
                  onPressed: () {
                    press('f');
                  },
                  child: Text(data['notation'] == 'Classic' ? 'Fá' : 'F',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.orange,
                      minimumSize: Size(60, 60)),
                  onPressed: () {
                    press('g');
                  },
                  child: Text(data['notation'] == 'Classic' ? 'Sol' : 'G',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              SizedBox(width: 5),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.orange,
                      minimumSize: Size(60, 60)),
                  onPressed: () {
                    press('a');
                  },
                  child: Text(data['notation'] == 'Classic' ? 'Lá' : 'A',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              SizedBox(width: 5),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.orange,
                      minimumSize: Size(60, 60)),
                  onPressed: () {
                    press('b');
                  },
                  child: Text(data['notation'] == 'Classic' ? 'Si' : 'B',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)))
            ],
          )
        ],
      ),
    );
  }
}
