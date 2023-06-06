import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '');
  bool isPlayer1Turn = true;
  bool gameEnded = false;

  void resetBoard() {
    setState(() {
      board = List.filled(9, '');
      isPlayer1Turn = true;
      gameEnded = false;
    });
  }

  void makeMove(int index) {
    if (board[index].isNotEmpty || gameEnded) {
      return;
    }

    setState(() {
      if (isPlayer1Turn) {
        board[index] = 'X';
      } else {
        board[index] = 'O';
      }

      isPlayer1Turn = !isPlayer1Turn;
      checkGameOver();
    });
  }

  void checkGameOver() {
    final winningPositions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (final positions in winningPositions) {
      final symbol = board[positions[0]];
      if (symbol.isNotEmpty &&
          board[positions[1]] == symbol &&
          board[positions[2]] == symbol) {
        gameEnded = true;
        break;
      }
    }

    if (!gameEnded && board.every((cell) => cell.isNotEmpty)) {
      gameEnded = true;
    }
  }

  Widget buildCell(int index) {
    return GestureDetector(
      onTap: () => makeMove(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return buildCell(index);
            },
          ),
          if (gameEnded)
            ElevatedButton(
              onPressed: resetBoard,
              child: Text('Reset'),
            ),
        ],
      ),
    );
  }
}
