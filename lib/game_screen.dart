import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/main_colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String resultDeclaration = '';
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Score Board',
                style: GoogleFonts.coiny(
                    textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
              )),
            ),
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
            Expanded(flex: 1, child: Text(resultDeclaration))
          ],
        ),
      ),
    );
  }

  void _ontapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
      } else if (oTurn == false && displayXO[index] == '') {
        displayXO[index] = 'X';
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Ist row
    if (displayXO[0].isNotEmpty &&
        displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2]) {
      setState(() {
        resultDeclaration = 'Player${displayXO[0]}wins';
      });
    } else if
        // 2nd Row
        (displayXO[3].isNotEmpty &&
            displayXO[3] == displayXO[4] &&
            displayXO[3] == displayXO[5]) {
      setState(() {
        resultDeclaration = 'Player${displayXO[3]}wins';
      });
    } else if
        // 3rd row
        (displayXO[6].isNotEmpty &&
            displayXO[6] == displayXO[7] &&
            displayXO[6] == displayXO[8]) {
      setState(() {
        resultDeclaration = 'Player${displayXO[6]}wins';
      });
    } else if
        //1st column
        (displayXO[0].isEmpty &&
            displayXO[0] == displayXO[3] &&
            displayXO[0] == displayXO[6]) {
      setState(() {
        resultDeclaration = resultDeclaration = 'Player${displayXO[0]}wins';
      });
    } else if
        //2nd column

        (displayXO[1].isNotEmpty &&
            displayXO[1] == displayXO[4] &&
            displayXO[1] == displayXO[7]) {
      setState(() {
        resultDeclaration = resultDeclaration = 'Player${displayXO[1]}wins';
      });
    } else if
        //3rd column
        (displayXO[2].isNotEmpty &&
            displayXO[2] == displayXO[5] &&
            displayXO[2] == displayXO[8]) {
      setState(() {
        resultDeclaration = resultDeclaration = 'Player${displayXO[2]}wins';
      });
    } else if
        // left to right diagonally
        (displayXO[0].isNotEmpty &&
            displayXO[0] == displayXO[4] &&
            displayXO[0] == displayXO[8]) {
      setState(() {
        resultDeclaration = resultDeclaration = 'Player${displayXO[0]}wins';
      });
    } else if
        // left to right diagonally
        (displayXO[2].isNotEmpty &&
            displayXO[2] == displayXO[4] &&
            displayXO[2] == displayXO[6]) {
      setState(() {
        resultDeclaration = resultDeclaration = 'Player${displayXO[2]}wins';
      });
    }
  }
}
