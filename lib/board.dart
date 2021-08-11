class Board {

  final List<List<int>> board;

  Board(this.board);

  Board.empty() : this(generateBoard());

  //generate an empty board
  static List<List<int>> generateBoard([int size = 3]) => List.generate(size, (i) => List.generate(size, (j) => 0));


  //@param gameBoard
  //@return 1 if the winner is X
  //        2 if the winner is O
  //        0 in the other statements
  int checkRowsColums() {
    for (int i = 0; i < board.length; i++) {
      int lastRow = 0, countRow = 0, lastColumn = 0, countColumn = 0;
      for (int j = 0; j < board.length; j++) {
        countRow += lastRow == board[i][j] && lastRow != 0 ? 1 : 0;
        lastRow = board[i][j];
        countColumn += lastColumn == board[j][i] && lastColumn != 0 ? 1 : 0;
        lastColumn = board[j][i];
      }
       if (countRow >= board.length - 1)
         return board[i][0];
       else if (countColumn >= board.length - 1)
         return board[0][i];
    }
    return 0;
  }

  int checkDiagonals() {
    if (board[(board.length-1)~/2][(board.length-1)~/2] == 0)
      return 0;
    int diag1 = board[0][0], diag1Count = 0, diag2 = board[board.length - 1][0], diag2Count = 0;
    for (int i = 1; i < board.length; i++) {
      diag1Count += diag1 == board[i][i] && diag1 != 0 ? 1 : 0;
      diag1 = board[i][i];
      diag2Count += diag2 == board[board.length - (i+1)][i] && diag2 != 0 ? 1 : 0;
      diag2 = board[board.length - (i+1)][i];
    }
    if (diag1Count >= board.length - 1)
      return diag1;
    else if (diag2Count >= board.length - 1)
      return diag2;
    else
      return 0;
  }

  int checkBoard() {
    int diagonal = checkDiagonals(), rowColumn = checkRowsColums();
    return rowColumn != 0 ? rowColumn : diagonal;
  }

  void addMove(int row, int column, int player) => board[row][column] != 0 ? throw FormatException('Place already used.') : board[row][column] = player;


  String spaceAdd(String string) => string + ' ';

  @override
  String toString([String separator = '---------', String space = ' ']) {
    String returnString = '';
    returnString += separator + '\n';
    for (int i = 0; i < board.length; i++) {
      returnString += spaceAdd('|');
      for (int j = 0; j < board.length; j++) {
        switch (board[i][j]) {
          case 0:
            returnString += spaceAdd('_');
            break;
          case 1:
            returnString += spaceAdd('X');
            break;
          case 2:
            returnString += spaceAdd('O');
            break;
        }
      }
      returnString += '|\n';
    }
    returnString += separator;
    return returnString;
  }

}