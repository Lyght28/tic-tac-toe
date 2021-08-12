import 'dart:io';

import 'package:tic_tac_toe/board.dart';

class Interface {

  int player;
  int lengthBoard;
  Interface(this.player, [this.lengthBoard = 3]);

  //verify that the user input is well between 1 and the length of the board
  bool verifyRangeUserInput(int userInput) => (1 <= userInput && userInput <= lengthBoard) ? true : false;

  //verify that the user input is well an int
  bool verifyTypeIntUserInput(String userInput) {
    try {
      int.parse(userInput);
      return true;
    } on FormatException {
      return false;
    }
  }

  //get and verify the move of the user
  int parseVerifyUserInput(String toPrint) {
    stdout.write(toPrint[0].toUpperCase()+toPrint.substring(1) + ': '); //Capitalize the first letter
    String? answerString = stdin.readLineSync();
    answerString = answerString ?? '';
    int answerInt = 0;
    if (!verifyTypeIntUserInput(answerString)){
      print('Incorrect input, please try again.');
      return parseVerifyUserInput(toPrint);
    }
    else
      answerInt = int.parse(answerString);
    if (!verifyRangeUserInput(answerInt)) {
      print('Input should be between 1 and $lengthBoard, please try again.');
      return parseVerifyUserInput(toPrint);
    } else
      return answerInt;
  }

  //return a list which contain in first position the row and the column in second
  List<int> getUserInput() {
    List<int> answers = [];
    print('Where do you want to play ?');
    answers.add(parseVerifyUserInput('row'));
    answers.add(parseVerifyUserInput('column'));
    return answers;
  }

  void explanation() {
    stdout.write('Do you want to see how to play ? (y/N): ');
    String answerString = stdin.readLineSync() ?? 'n';
    bool answerBool = answerString.toUpperCase() == 'Y' ? true : false;
    if (answerBool)
      print('Just give the number of the row (horizontal) and the column (vertical) you want to play.\n'
          'They are numbered from 1 to 3\n'
          'Try to win ;)');
  }

  //update the board according to the user choice
  void makeMove(Board board) {
    List<int> userInput = getUserInput();
    try {
      board.addMove(userInput[0] - 1 , userInput[1] - 1, player);
    } on FormatException catch (e) {
      print(e.message);
      makeMove(board);
    }
  }

  //a turn for a player (it return if the game is ended or not)
  bool turn(Board board) {
    print(board);
    makeMove(board);
    return board.checkBoard() == 0 ? true : false;
  }
  //print whether this interface player has win or not
  void printResult(Board board) {
    int result = board.checkBoard();
    switch (result) {
      case 1:
      case 2:
        if (result == player)
          print('GG you have win with the ${board.symbols[result]}.');
        else
          print("Oh no, you've lost against the ${board.symbols[result]}.");
        break;
      case -1:
      default:
        print("It's a draw.");
        break;
    }
  }

}