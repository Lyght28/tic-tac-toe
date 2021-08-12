import 'dart:math';

import 'package:tic_tac_toe/board.dart';

class AI {

  int player;
  AI(this.player);

  num minmax(Board board, int depth, bool isMax,) {
    int score = evaluate(board);
    List<List<int>> gameboard = board.board;

    switch(score) {
      case 10:
      case -10:
        return score;
      case -1:
        return 0;
      case 0:
      default:
        if (isMax) {
          num best = -double.infinity;
          for (int i = 0; i < gameboard.length; i++) {
            for (int j = 0; j < gameboard[i].length; j++) {
              if (board.caseIsEmpty(i, j)) {
                Board newBoard = Board(board.board);
                newBoard.addMove(i, j, player);
                best = max(best, minmax(newBoard, depth + 1, !isMax));
                newBoard.removeMove(i, j);
              }
            }
          }
          return best;
        } else {
          num best = double.infinity;
          for (int i = 0; i < gameboard.length; i++) {
            for (int j = 0; j < gameboard[i].length; j++) {

              if (board.caseIsEmpty(i, j)) {
                Board newBoard = Board(board.board);
                newBoard.addMove(i, j, player == 1 ? 2 : 1);
                best = min(best, minmax(newBoard, depth + 1, !isMax));
                newBoard.removeMove(i, j);
              }
            }
          }
          return best;
        }
    }
  }

  int evaluate(Board board) {
    int result = board.checkBoard();
    switch (result) {
      case 1:
      case 2:
        return result == player ? 10 : -10;
      case -1:
        return -1;
      case 0:
      default:
        return 0;
    }
  }

  List<int> findBestMove(Board board) {
    List<List<int>> gameboard = board.board;
    num bestVal = -double.infinity;
    List<int> bestMove = [-1, -1];

    for (int i = 0; i < gameboard.length; i++) {
      for (int j = 0; j < gameboard[i].length; j++) {
          if (board.caseIsEmpty(i, j)) {
            Board newBoard = Board(board.board);
            newBoard.addMove(i, j, player);
            num moveVal = minmax(newBoard, 0, false);
            newBoard.removeMove(i, j);
            if (moveVal > bestVal) {
              bestMove = [i, j];
              bestVal = moveVal;
            }
          }
      }
    }
    return bestMove;
  }

  bool turn(Board board) {
    List<int> move = findBestMove(board);
    board.addMove(move[0], move[1], player);
    return board.checkBoard() == 0 ? true : false;
  }
}