import 'dart:io';

import 'package:tic_tac_toe/board.dart';

class Interface {

  int player;
  Interface(this.player);

  bool verifRangeUserInput(int userInput) => (1 <= userInput && userInput <= 3) ? true : false;

  int parseVerifyUserInput(String toPrint) {
    stdout.write(toPrint + ': ');
    String? answerString = stdin.readLineSync();
    answerString = answerString ?? '';
    int answerInt;
    try {
      answerInt = int.parse(answerString);
    } on FormatException {
      print('Incorrect input, please try again.');
      return parseVerifyUserInput(toPrint);
    }
    if (!(1 <= answerInt && answerInt <= 3)) {
      print('Input should be between 1 and 3, please try again.');
      return parseVerifyUserInput(toPrint);
    } else
      return answerInt;
  }

  List<int> getUserInput() {
    List<int> answers = [];
    print('Where do you want to play ?');
    answers.add(parseVerifyUserInput('Row'));
    answers.add(parseVerifyUserInput('Column'));
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

  void makeMove(Board board) {
    List<int> userInput = getUserInput();
    try {
      board.addMove(userInput[0] - 1 , userInput[1] - 1, player);
    } on FormatException catch (e) {
      print(e.message);
      makeMove(board);
    }
  }

  bool turn(Board board) {
    print(board);
    makeMove(board);
    return board.checkBoard() == 0 ? true : false;
  }

  void printResult(Board board) {
    //TODO change this print system to show whether this interface player has win or not
    switch (board.checkBoard()) {
      case 0:
        print("It's a draw?");
        break;
      case 1:
        print('GG, the X player win.');
        break;
      case 2:
        print('GG, the O player win.');
    }
  }

}