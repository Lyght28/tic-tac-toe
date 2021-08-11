import 'package:tic_tac_toe/board.dart';
import 'package:tic_tac_toe/interface.dart';

void main(List<String> arguments) {
  Board board = Board.empty();
  Interface player1 = Interface(1);
  Interface player2 = Interface(2);
  player1.explanation();
  int nbTurn = 0;
  while (true) {
    if (!player1.turn(board) || ++nbTurn >= 8)
      break;
    if (!player2.turn(board) || ++nbTurn >= 8)
      break;
  }
  player1.printResult(board);
  //TODO Had the possibility to play against computer or player
}
