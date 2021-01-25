import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static String classic = 'Classic';
  static String bass = 'Bass';

  String selectedNotation = classic;
  List<String> notations = [classic, 'Letter'];

  int selectedLedgerLines = 0;
  List<int> ledgerLines = [0, 1, 2, 3, 4, 5];

  String selectedClefs = bass;
  List<String> clefs = [bass, 'Treble'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Sheet music fluency practice'),
          backgroundColor: Colors.green[800],
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome!',
                  style: TextStyle(fontSize: 40.0, letterSpacing: 2.0, fontWeight: FontWeight.bold)),
              Text('Choose the desired config and press play.'),
              Card(
                color: Colors.lightGreen[50],
                margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Notation:', style: TextStyle(fontSize: 20.0)),
                        SizedBox(width: 20.0),
                        DropdownButton(
                            value: selectedNotation,
                            onChanged: (value) {
                              setState(() {
                                selectedNotation = value;
                              });
                            },
                            items: notations
                                .map((item) => DropdownMenuItem(
                                    value: item, child: Text(item)))
                                .toList())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ledger lines:', style: TextStyle(fontSize: 20.0)),
                        SizedBox(width: 20.0),
                        DropdownButton(
                            value: selectedLedgerLines,
                            onChanged: (value) {
                              setState(() {
                                selectedLedgerLines = value;
                              });
                            },
                            items: ledgerLines
                                .map((item) => DropdownMenuItem(
                                    value: item, child: Text(item.toString())))
                                .toList())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Clef:', style: TextStyle(fontSize: 20.0)),
                        SizedBox(width: 20.0),
                        DropdownButton(
                            value: selectedClefs,
                            onChanged: (value) {
                              setState(() {
                                selectedClefs = value;
                              });
                            },
                            items: clefs
                                .map((item) => DropdownMenuItem(
                                    value: item, child: Text(item)))
                                .toList())
                      ],
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            child: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.pushNamed(context, '/practice', arguments: {
                'notation': selectedNotation,
                'ledgerLines': selectedLedgerLines,
                'clefs': selectedClefs
              });
            }));
  }
}
