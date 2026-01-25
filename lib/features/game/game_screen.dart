import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game name"), centerTitle: true),
      body: GridView.builder(
        itemCount: 8 * 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(3.0),
          child: GestureDetector(
            onTap: () => print('tap: $index'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
