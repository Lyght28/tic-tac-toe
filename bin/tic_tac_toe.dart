import 'package:tic_tac_toe/ai.dart';
import 'package:tic_tac_toe/board.dart';
import 'package:tic_tac_toe/interface.dart';

void main(List<String> arguments) {
  Board board = Board.empty();
  Interface player1 = Interface(1);
  AI player2 = AI(2);
  player1.explanation();
  while (true) {
    if (!player1.turn(board))
      break;
    if (!player2.turn(board))
      break;
  }
  print(board);
  player1.printResult(board);
  //TODO Had the possibility to play against computer or player and to play first or second
}
