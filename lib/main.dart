import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const QuizyPopApp());
}

class QuizyPopApp extends StatelessWidget {
  const QuizyPopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizy Pop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFF0088),
          secondary: Color(0xFFFF69B4),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}