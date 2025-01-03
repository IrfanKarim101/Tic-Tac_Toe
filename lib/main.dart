import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tictactoe/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic Tac Toe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Intro());
  }
}

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    String playerName = 'Player';
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
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
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  'Welcome to Tic Tac Toe',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Enter your name:',
                  style: TextStyle(color: Colors.grey),
                ),
                TextField(
                  controller: controller,
                  onChanged: (value) {
                    playerName = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Your Name',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 65,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(playerTitle: playerName)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 6.0,
                    ),
                    child: const Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
