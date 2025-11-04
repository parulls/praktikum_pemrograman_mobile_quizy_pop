import 'package:flutter/material.dart';
import 'package:praktikum_pemrograman_mobile_quizy_pop/screens/question_screen.dart';

class SubjectScreen extends StatefulWidget {
  final String userName;

  const SubjectScreen({super.key, this.userName = 'Jane Done'});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  bool _visible = false;

  // Data untuk subjects
  final List<Map<String, dynamic>> _subjects = [
    {'name': 'Science', 'color': Color(0xFFFF93C7), 'icon': Icons.science_outlined},
    {'name': 'History', 'color': Color(0xFFF293FF), 'icon': Icons.history_edu_outlined},
    {'name': 'Geography', 'color': Color(0xFF93A1FF), 'icon': Icons.public_outlined},
    {'name': 'Sports', 'color': Color(0xFF93FFAE), 'icon': Icons.sports_soccer_outlined},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  void _selectSubject(String subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionScreen(
          userName: widget.userName,
          subject: subject,
        ),
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
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: 20,
                      ),
                      child: _buildSubjectCard(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader2(),
          const SizedBox(height: 30),
          _buildSubjectGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader2() {
    return Column(
      children: [
        Text(
          'Welcome, ${widget.userName}!',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.04,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Choose a category to begin',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF595959),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectGrid() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSubjectCard2(
              _subjects[0]['name'],
              _subjects[0]['color'],
              _subjects[0]['icon'],
            ),
            const SizedBox(width: 10),
            _buildSubjectCard2(
              _subjects[1]['name'],
              _subjects[1]['color'],
              _subjects[1]['icon'],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSubjectCard2(
              _subjects[2]['name'],
              _subjects[2]['color'],
              _subjects[2]['icon'],
            ),
            const SizedBox(width: 10),
            _buildSubjectCard2(
              _subjects[3]['name'],
              _subjects[3]['color'],
              _subjects[3]['icon'],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubjectCard2(String name, Color color, IconData icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectSubject(name),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}