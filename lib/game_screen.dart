import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/main_colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Timer? timer;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  bool winnerFound = false;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {});
    if (seconds > 0) {
      seconds--;
    } else {
      resetTimer();
      sTopTimer();
    }
  }

  void sTopTimer() {
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Player O',
                          style: GoogleFonts.coiny(
                              textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          oScore.toString(),
                          style: GoogleFonts.coiny(
                              textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Player X',
                          style: GoogleFonts.coiny(
                              textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          xScore.toString(),
                          style: GoogleFonts.coiny(
                              textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          )),
                        ),
                      ],
                    )
                  ],
                )),
            Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _ontapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 5,
                              color: MainColors.primaryColor,
                            ),
                            color: MainColors.secondaryColor,
                          ),
                          child: Center(
                              child: Text(displayXO[index],
                                  style: GoogleFonts.coiny(
                                      textStyle: TextStyle(
                                    fontSize: 67,
                                    color: MainColors.primaryColor,
                                  )))),
                        ),
                      );
                    })),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      resultDeclaration,
                      style: GoogleFonts.coiny(
                          textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        onPressed: () {
                          _clearBoard();
                        },
                        child: const Text('Play Again'))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _ontapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledBoxes++;
      } else if (oTurn == false && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledBoxes++;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _clearBoard() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
  }

  void checkScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _checkWinner() {
    // Ist row
    if (displayXO[0].isNotEmpty &&
        displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2]) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} wins!';
        checkScore(displayXO[0]);
      });
    } else if
        // 2nd Row
        (displayXO[3].isNotEmpty &&
            displayXO[3] == displayXO[4] &&
            displayXO[3] == displayXO[5]) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[3]} wins!';
        checkScore(displayXO[3]);
      });
    } else if
        // 3rd row
        (displayXO[6].isNotEmpty &&
            displayXO[6] == displayXO[7] &&
            displayXO[6] == displayXO[8]) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[6]} wins!';
        checkScore(displayXO[6]);
      });
    } else if
        //1st column
        (displayXO[0].isEmpty &&
            displayXO[0] == displayXO[3] &&
            displayXO[0] == displayXO[6]) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} wins!';
        checkScore(displayXO[0]);
      });
    } else if
        //2nd column

        (displayXO[1].isNotEmpty &&
            displayXO[1] == displayXO[4] &&
            displayXO[1] == displayXO[7]) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[1]} wins!';
        checkScore(displayXO[1]);
      });
    } else if
        //3rd column
        (displayXO[2].isNotEmpty &&
            displayXO[2] == displayXO[5] &&
            displayXO[2] == displayXO[8]) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[2]} wins!';
        checkScore(displayXO[2]);
      });
    } else if
        // left to right diagonally
        (displayXO[0].isNotEmpty &&
            displayXO[0] == displayXO[4] &&
            displayXO[0] == displayXO[8]) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} wins!';
        checkScore(displayXO[0]);
      });
    } else if
        // left to right diagonally
        (displayXO[2].isNotEmpty &&
            displayXO[2] == displayXO[4] &&
            displayXO[2] == displayXO[6]) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[2]} wins!';
        checkScore(displayXO[2]);
      });
    } else if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody won!';
      });
    }
  }
}
