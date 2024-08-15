import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  int ohscore = 0;
  int exscore = 0;
  int filledboxes = 0;
  bool ohturn = true; // the first person is 0!
  List<String> displayExoh = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('PLAYER O',
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                      Text(
                        ohscore.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('PLAYER X',
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                    Text(
                      exscore.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )
                  ],
                ),
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          displayExoh[index],
                          //index.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              //flex: 1,
              child: Container(
            height: 80,
            width: 430,
            child: Center(
                child: Column(
              children: [
                Text("'TIC TAC TOE'",
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '@MEHARSAADULLAH',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            )),
            color: Colors.black,
          )),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohturn && displayExoh[index] == '') {
        displayExoh[index] = 'O';
        filledboxes += 1; // when tapped add 1 in integor filledbox
      } else if (!ohturn && displayExoh[index] == '') {
        displayExoh[index] = 'X';
        filledboxes += 1; // when tapped add 1 in integor filledbox
      }
      ohturn = !ohturn; // these is to change to player after one turn
      _checkwinner();
    });
  }

  void _checkwinner() {
    bool winnerFound = false;

//// check 1st row
    if (displayExoh[0] == displayExoh[1] &&
        displayExoh[0] == displayExoh[2] &&
        displayExoh[0] != '') {
      _showdialog(displayExoh[0]);
      winnerFound = true;
    }

//// check 2nd row
    if (displayExoh[3] == displayExoh[4] &&
        displayExoh[3] == displayExoh[5] &&
        displayExoh[3] != '') {
      _showdialog(displayExoh[3]);
      winnerFound = true;
    }

// check 3rd row
    if (displayExoh[6] == displayExoh[7] &&
        displayExoh[6] == displayExoh[8] &&
        displayExoh[6] != '') {
      _showdialog(displayExoh[6]);
      winnerFound = true;
    }

// check 1st column

    if (displayExoh[0] == displayExoh[3] &&
        displayExoh[0] == displayExoh[6] &&
        displayExoh[0] != '') {
      _showdialog(displayExoh[0]);
      winnerFound = true;
    }

// check 2nd column
    if (displayExoh[1] == displayExoh[4] &&
        displayExoh[1] == displayExoh[7] &&
        displayExoh[1] != '') {
      _showdialog(displayExoh[1]);
      winnerFound = true;
    }

// check 3rd column

    if (displayExoh[2] == displayExoh[5] &&
        displayExoh[2] == displayExoh[8] &&
        displayExoh[2] != '') {
      _showdialog(displayExoh[2]);
      winnerFound = true;
    }

// check diagonal
    if (displayExoh[6] == displayExoh[4] &&
        displayExoh[6] == displayExoh[2] &&
        displayExoh[6] != '') {
      _showdialog(displayExoh[6]);
      winnerFound = true;
    }

// check diagonal
    if (displayExoh[0] == displayExoh[4] &&
        displayExoh[0] == displayExoh[8] &&
        displayExoh[0] != '') {
      _showdialog(displayExoh[0]);
      winnerFound = true;
    }
    // if no one will win then this part will execute
    else if (!winnerFound && filledboxes == 9) {
      _showDrawdialog();
    }
  }

// Draw Dialog
  void _showDrawdialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('This match in Drawn'),
            actions: [
              TextButton(
                  child: Text('PLAY AGAIN!'),
                  onPressed: () {
                    _clearBoard();

                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

// win dialog
  void _showdialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(' The Winner is : ' + winner),
            actions: [
              TextButton(
                  child: Text('PLAY AGAIN!'),
                  onPressed: () {
                    _clearBoard();

                    Navigator.of(context).pop();
                  })
            ],
          );
        });

    if (winner == 'O') {
      ohscore += 1;
    } else if (winner == 'X') {
      exscore += 1;
    }
  }

// create function to clear the game and play again
  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExoh[i] = '';
      }
    });
    filledboxes = 0;
  }
}
