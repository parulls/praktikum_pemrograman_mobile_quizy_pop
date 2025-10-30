import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praktikum_pemrograman_mobile_quizy_pop/screens/subject_screen.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Fade in otomatis saat build
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => _visible = true);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _showSnack('Please enter your name!', const Color(0xFFFF69B4));
      return;
    }
    _showSnack('Welcome, $name!', const Color(0xFFFF1493));
  }

  void _showSnack(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF69B4), Color(0xFFFF1493)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1000),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.22,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Welcome Card
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 35),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'Welcome to\n',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'QuizzyPop ',
                                  style: TextStyle(
                                    color: Color(0xFFFF1493),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Academy!',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Test Your Knowledge & Shine!',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.06),

                  // Input
                  TextField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter Your Name',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 10),
                          child: const Icon(Icons.person_outline, color: Colors.white, size: 28),
                        ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  // Button
                  CustomButton(
                    text: 'START QUIZ',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubjectScreen(),
                          ),
                          );
                          },
                          backgroundColor: Colors.white,
                          textColor: const Color(0xFFFF1493),
                          ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
