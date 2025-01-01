import 'dart:ui';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String winner;
  final VoidCallback onRestart;

  const ResultPage({super.key, required this.winner, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Game Result',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner == 'Tie' ? 'It\'s a Tie!' : ' $winner',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onRestart,
                  child: const Text('Restart'),
                ),
              ],
            ),
          ),
        ]));
  }
}
