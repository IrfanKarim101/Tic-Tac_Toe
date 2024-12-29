import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  String title;
  MyHomePage({super.key, required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> _colors = List.filled(9, Colors.white);
  bool _isPlayerOneTurn = true;
  String _winner = '';

  void _handleTap(int index) {
    if (_colors[index] == Colors.white && _winner == '') {
      setState(() {
        _colors[index] = _isPlayerOneTurn ? Colors.blue : Colors.red;
        _isPlayerOneTurn = !_isPlayerOneTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    List<List<int>> winningCombinations = [
      //--> these are the possible winning combinations
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (_colors[combination[0]] != Colors.white &&
          _colors[combination[0]] == _colors[combination[1]] &&
          _colors[combination[1]] == _colors[combination[2]]) {
        _winner = _colors[combination[0]] == Colors.blue
            ? 'Player One'
            : 'Player Two';
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _winner.isEmpty
                ? 'Turn: ${_isPlayerOneTurn ? 'Player One' : 'Player Two'}'
                : 'Winner: $_winner',
            style: const TextStyle(fontSize: 24),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  color: _colors[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
