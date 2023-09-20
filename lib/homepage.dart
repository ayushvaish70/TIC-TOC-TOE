import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myHomepage extends StatefulWidget {
  const myHomepage({super.key});

  @override
  State<myHomepage> createState() => _myHomepageState();
}

class _myHomepageState extends State<myHomepage> {

  bool ohTurn = true; //the first player is 0!

  List<String> displayExOh = ["", "", "", "", "", "", "", "", ""];

  var style = TextStyle(color: Colors.white, fontSize: 30);
  var style2 = TextStyle(color: Colors.white, fontSize: 20);
  int Ohscore=0;
  int eXscore=0;
  int filledboxes=0;

  static var myNewFont=GoogleFonts.pressStart2p(
    textStyle:TextStyle(color: Colors.black,letterSpacing: 3)
  );
  static var myNewFontWhite=GoogleFonts.pressStart2p(
      textStyle:TextStyle(color: Colors.white,letterSpacing: 3,fontSize: 12)
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Player:X", style: myNewFontWhite),
                            SizedBox(height: 5,),
                            Text(eXscore.toString(), style: myNewFontWhite)
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Player:O", style: myNewFontWhite),
                            SizedBox(height: 5,),
                            Text(Ohscore.toString(), style: myNewFontWhite)
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
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
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Text(
                            displayExOh[index],
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(

                children: [
                  Text("TIC TAC TOE",style: myNewFontWhite,),
                  SizedBox(height: 8,),
                  Text("BY",style: myNewFontWhite,),
                  SizedBox(height: 8,),
                  Text("@Ayush_vaish",style: myNewFontWhite,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {

    setState(() {
      if (ohTurn==true && displayExOh[index]=="") {
        displayExOh[index] = "o";
        filledboxes+=1;
      } else  if(ohTurn==false && displayExOh[index]==""){
        displayExOh[index] = "x";
        filledboxes+=1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      return showWinDialouge(displayExOh[0]);
    }
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {return showWinDialouge(displayExOh[3]);}
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {return showWinDialouge(displayExOh[6]);}
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {return showWinDialouge(displayExOh[0]);}
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {return showWinDialouge(displayExOh[1]);}
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {return showWinDialouge(displayExOh[2]);}
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {return showWinDialouge(displayExOh[0]);}
    if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != '') {return showWinDialouge(displayExOh[2]);}
    else if(filledboxes==9){
      showDrawDialouge();
    }
  }

  void showWinDialouge(String winner) {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            title: Text("Winner is: "+ winner),
            actions:<Widget> [
              Text("play again"),
               FloatingActionButton(child: Center(child: Text("play again")),onPressed:(){
                 _clearBoard();
                 Navigator.of(context).pop();
               })
            ],
          );
        });
    if (winner=="o"){
      Ohscore+=1;

    }else if(winner=="x"){
      eXscore+=1;

    }
  }
  void _clearBoard(){
    setState(() {
      for(int i=0; i<9;i++){
        displayExOh[i]="";

      }
    });
    filledboxes=0;
  }
  void showDrawDialouge(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("DRAW"),
            actions:<Widget> [
              Text("play again"),
              FloatingActionButton(child: Center(child: Text("play again")),onPressed:(){
                _clearBoard();
                Navigator.of(context).pop();
              })
            ],
          );
        });
  }
}
