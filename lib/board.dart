class Board {

  final List<List<int>> board;
  final Map<int, String>  symbols;

  Board(this.board, [this.symbols = const {
    0: '_',
    1: 'X',
    2: 'O'
  }]);

  //the constructor to get an empty board
  Board.empty() : this(generateBoard());

  //generate an empty board
  static List<List<int>> generateBoard([int size = 3]) => List.generate(size, (i) => List.generate(size, (j) => 0));

  //indicate whether a case is empty or not
  bool caseIsEmpty(int row, int column) => board[row][column] == 0 ? true : false;


  //@param gameBoard
  //@return 1 if the winner is the player with 1 (X)
  //        2 if the winner is the player with 2 (O)
  //        -1 if it's a draw
  //        0 in the other statements
  int checkRowsColumns() {
    int nbMoves = 0;
    for (int i = 0; i < board.length; i++) {
      int lastRow = 0, countRow = 0, lastColumn = 0, countColumn = 0;
      for (int j = 0; j < board.length; j++) {
        nbMoves += caseIsEmpty(i, j) ? 0 : 1;
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
    return nbMoves >= 8 ? -1 : 0;
  }

  //@param gameBoard
  //@return 1 if the winner is the player with 1 (X)
  //        2 if the winner is the player with 2 (O)
  //        0 in the other statements
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

  //combine checkDiagonals() and checkRowsColumns() to see if there's a winner or a draw
  int checkBoard() {
    int diagonal = checkDiagonals(), rowColumn = checkRowsColumns();
    return diagonal != 0 ? diagonal : rowColumn; //prioritize the rowColumn because it could return -1 (draw)
  }

  void addMove(int row, int column, int player) => board[row][column] != 0 ? throw FormatException('Place already used.') : board[row][column] = player;
  void removeMove(int row, int column) => board[row][column] == 0 ? throw FormatException('Place not used.') : board[row][column] = 0;

  //just to simplify the format of the toString
  String spaceAdd(String ?string) => (string ?? ' ') + ' ';

  @override
  String toString([String separator = '---------', String space = ' ']) {
    String returnString = '';
    returnString += separator + '\n';
    for (int i = 0; i < board.length; i++) {
      returnString += spaceAdd('|');
      for (int j = 0; j < board.length; j++) {
        returnString += spaceAdd(symbols[board[i][j]]);
      }
      returnString += '|\n';
    }
    returnString += separator;
    return returnString;
  }

}