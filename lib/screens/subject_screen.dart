import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
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

                  SizedBox(height: size.height * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
