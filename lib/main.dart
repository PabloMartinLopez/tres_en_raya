import 'package:flutter/material.dart';
import 'package:tres_en_raya/features/List/List_screen.dart';
import 'package:tres_en_raya/features/login/Login_screen.dart';

import 'features/game/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginScreen(),
        '/list':(context)=>ListScreen(),
        '/game':(context)=>GameScreen(),
      },
    );
  }
}
