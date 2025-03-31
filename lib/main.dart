import 'package:flutter/material.dart';
import 'package:projet_flutter/features/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFPro',
      ),
      home: const HomeScreen()
      
    );
  }
}
