import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'result.dart';

class MyHomePage extends StatefulWidget {
  final String playerTitle;
  const MyHomePage({super.key, required this.playerTitle});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> _colors = List.filled(9, Colors.white);
  bool _isPlayerOneTurn = true;
  String _winner = '';
  final Random _random = Random();

  void _handleTap(int index) {
    if (_colors[index] == Colors.white && _winner == '') {
      setState(() {
        _colors[index] = Colors.blue;
        _isPlayerOneTurn = false;
        _checkWinner();
        if (_winner == '') {
          _computerMove();
        }
      });
    }
  }

  void _computerMove() {
    List<int> availableMoves = [];
    for (int i = 0; i < _colors.length; i++) {
      if (_colors[i] == Colors.white) {
        availableMoves.add(i);
      }
    }
    if (availableMoves.isNotEmpty) {
      int move = availableMoves[_random.nextInt(availableMoves.length)];
      setState(() {
        _colors[move] = Colors.red;
        _isPlayerOneTurn = true;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    List<List<int>> winningCombinations = [
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
        setState(() {
          _winner = _colors[combination[0]] == Colors.blue
              ? widget.playerTitle
              : 'Computer';
        });
        showResult();
        return;
      }
    }
    if (_colors.every((color) => color != Colors.white)) {
      setState(() {
        _winner = 'Tie';
      });
      showResult();
    }
  }

  void showResult() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultPage(
          winner: _winner == 'Tie' ? 'It\'s a Tie!' : 'Winner: $_winner',
          onRestart: () {
            Navigator.of(context).pop();
            _restartGame();
          },
        ),
      ),
    );
  }

  void _restartGame() {
    setState(() {
      _colors.fillRange(0, _colors.length, Colors.white);
      _isPlayerOneTurn = true;
      _winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.playerTitle),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 90, sigmaY: 90, tileMode: TileMode.clamp),
            child: Container()),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _winner.isEmpty
                  ? 'Turn: ${_isPlayerOneTurn ? widget.playerTitle : 'Computer'}'
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
      ]),
    );
  }
}
