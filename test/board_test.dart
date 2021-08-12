import 'package:tic_tac_toe/board.dart';
import 'package:test/test.dart';

void main() {
  Board emptyBoard = Board.empty();
  test('generate board', () {
    expect(emptyBoard.board, equals([[0,0,0],[0,0,0],[0,0,0]]));
  });

  group('check board', () {
    test('check rows columns board', () {
      expect(emptyBoard.checkRowsColumns(), equals(0));
      expect(Board([[1,0,1], [0,1,2], [2,0,2]]).checkRowsColumns(), equals(0));

      expect(Board([[1,1,1], [0,2,0], [2,0,2]]).checkRowsColumns(), equals(1));
      expect(Board([[1,0,1], [1,2,2], [1,0,2]]).checkRowsColumns(), equals(1));

      expect(Board([[1,2,1], [0,2,0], [1,2,1]]).checkRowsColumns(), equals(2));
      expect(Board([[1,0,1], [0,1,0], [2,2,2]]).checkRowsColumns(), equals(2));
    });

    test('check diagonals board', () {
      expect(emptyBoard.checkDiagonals(), equals(0));
      expect(Board([[1,1,1], [0,2,0], [2,0,2]]).checkDiagonals(), equals(0));

      expect(Board([[1,0,2], [0,1,2], [2,0,1]]).checkDiagonals(), equals(1));
      expect(Board([[2,0,1], [0,1,2], [1,0,2]]).checkDiagonals(), equals(1));

      expect(Board([[2,0,1], [0,2,0], [1,1,2]]).checkDiagonals(), equals(2));
      expect(Board([[1,0,2], [0,2,0], [2,1,1]]).checkDiagonals(), equals(2));
    });

    test('check board', () {
      expect(emptyBoard.checkBoard(), equals(0));
      expect(Board([[1,1,1], [0,2,0], [2,0,2]]).checkBoard(), equals(1));
      expect(Board([[1,0,2], [0,2,0], [2,1,1]]).checkBoard(), equals(2));
    });
  });
  


  test('add move', () {
    Board board1 = Board.empty(), board2 = Board([[1,0,2], [0,2,0], [2,1,1]]);
    board1.addMove(1, 1, 1);
    expect(board1.board, equals([[0,0,0],[0,1,0],[0,0,0]]));
    
    expect(() => board2.addMove(2, 2, 1), throwsFormatException);
  });
}
