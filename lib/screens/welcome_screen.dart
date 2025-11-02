import 'package:flutter/material.dart';
import 'package:praktikum_pemrograman_mobile_quizy_pop/screens/subject_screen.dart';

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
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _visible = true);
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

    _showSnack('Welcome, $name!', const Color(0xFFFF0088));

    Future.delayed(const Duration(milliseconds: 600), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SubjectScreen(),
        ),
      );
    });
  }

  void _showSnack(String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFEEEE),
              Color(0xFFFFEFD2),
              Color(0xFFF9CDF7),
              Color(0xFFFFAAE7),
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1000),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', width: size.width),
                    SizedBox(height: size.height * 0.01),
                    _buildWelcomeCard(),
                    SizedBox(height: size.height * 0.06),
                    _buildNameInput(),
                    SizedBox(height: size.height * 0.03),
                    _buildStartButton(),
                    SizedBox(height: size.height * 0.05),
                    _buildBottomIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.20),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: const [
                TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                    color: Color(0xFF191919),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'QuizzyPop',
                  style: TextStyle(
                    color: Color(0xFFFF0088),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: ' Academy!',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            style: const TextStyle(fontSize: 28, height: 1.1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          const Text(
            'Test Your Knowledge & Shine!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFA6A6A6),
              fontWeight: FontWeight.w500,
              letterSpacing: -0.72,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameInput() {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.60),
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: const Color(0xFFFF0088)),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        TextField(
          controller: _nameController,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFFFF0088),
            fontWeight: FontWeight.w500,
            letterSpacing: -0.8,
          ),
          decoration: InputDecoration(
            hintText: 'Enter Your Name',
            hintStyle: TextStyle(
              color: const Color(0xFFFF0088).withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),

        const Positioned(
          left: 25,
          child: Icon(
            Icons.person,
            color: Color(0xFFFF0088),
            size: 22,
          ),
        ),
      ],
    ),
  );
}

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: _startQuiz,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFFF0088),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Start Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomIndicator() {
    return Container(
      width: 135,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
