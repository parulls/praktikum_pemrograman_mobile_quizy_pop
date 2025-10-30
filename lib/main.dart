import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const QuizyPopApp());
}

class QuizyPopApp extends StatelessWidget {
  const QuizyPopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizy Pop',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF1493), // Deep Pink Barbie
          brightness: Brightness.light,
          primary: const Color(0xFFFF69B4),
          secondary: const Color(0xFFFFB6D9),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const WelcomeScreen(),
    );
  }
}