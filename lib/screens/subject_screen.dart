import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/theme_toggle_widget.dart';
import '../utils/app_theme.dart';
import 'question_screen.dart';

class SubjectScreen extends StatefulWidget {
  final String userName;

  const SubjectScreen({super.key, required this.userName});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> with SingleTickerProviderStateMixin {
  bool _visible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _subjects = [
    {'name': 'Science', 'color': const Color(0xFFFF93C7), 'icon': Icons.science_outlined},
    {'name': 'History', 'color': const Color(0xFFF293FF), 'icon': Icons.history_edu_outlined},
    {'name': 'Geography', 'color': const Color(0xFF93A1FF), 'icon': Icons.public_outlined},
    {'name': 'Sports', 'color': const Color(0xFF93FFAE), 'icon': Icons.sports_soccer_outlined},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _visible = true);
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectSubject(String subject) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.initializeQuiz(subject, widget.userName);

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const QuestionScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppTheme.getGradientColors(context),
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(isLandscape ? 12 : constraints.maxWidth * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              size: isLandscape ? 20 : 24,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const ThemeToggleWidget(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: isLandscape ? 20 : constraints.maxWidth * 0.05,
                            vertical: isLandscape ? 10 : constraints.maxHeight * 0.02,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isLandscape ? 900 : 400,
                            ),
                            child: _buildSubjectCard(constraints, isLandscape),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BoxConstraints constraints, bool isLandscape) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isLandscape ? 20 : constraints.maxWidth * 0.05),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
          _buildHeader(constraints, isLandscape),
          SizedBox(height: isLandscape ? 20 : constraints.maxHeight * 0.04),
          _buildSubjectGrid(constraints, isLandscape),
        ],
      ),
    );
  }

  Widget _buildHeader(BoxConstraints constraints, bool isLandscape) {
    return Column(
      children: [
        Text(
          'Welcome, ${widget.userName}!',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
            fontSize: isLandscape ? 20 : constraints.maxWidth * 0.055,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isLandscape ? 5 : constraints.maxHeight * 0.01),
        Text(
          'Choose a category to begin',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: isLandscape ? 14 : constraints.maxWidth * 0.04,
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectGrid(BoxConstraints constraints, bool isLandscape) {
    if (isLandscape) {
      return Row(
        children: _subjects.map((subject) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: _buildSubjectCard2(
                subject['name'],
                subject['color'],
                subject['icon'],
                constraints,
                isLandscape,
              ),
            ),
          );
        }).toList(),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSubjectCard2(
                _subjects[0]['name'],
                _subjects[0]['color'],
                _subjects[0]['icon'],
                constraints,
                isLandscape,
              ),
            ),
            SizedBox(width: constraints.maxWidth * 0.025),
            Expanded(
              child: _buildSubjectCard2(
                _subjects[1]['name'],
                _subjects[1]['color'],
                _subjects[1]['icon'],
                constraints,
                isLandscape,
              ),
            ),
          ],
        ),
        SizedBox(height: constraints.maxHeight * 0.02),
        Row(
          children: [
            Expanded(
              child: _buildSubjectCard2(
                _subjects[2]['name'],
                _subjects[2]['color'],
                _subjects[2]['icon'],
                constraints,
                isLandscape,
              ),
            ),
            SizedBox(width: constraints.maxWidth * 0.025),
            Expanded(
              child: _buildSubjectCard2(
                _subjects[3]['name'],
                _subjects[3]['color'],
                _subjects[3]['icon'],
                constraints,
                isLandscape,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubjectCard2(String name, Color color, IconData icon, BoxConstraints constraints, bool isLandscape) {
    return GestureDetector(
      onTap: () => _selectSubject(name),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isLandscape ? 100 : constraints.maxHeight * 0.15,
        constraints: BoxConstraints(
          minHeight: isLandscape ? 100 : 100,
          maxHeight: isLandscape ? 100 : 150,
        ),
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
            Icon(
              icon,
              color: Colors.white,
              size: isLandscape ? 30 : constraints.maxWidth * 0.1,
            ),
            SizedBox(height: isLandscape ? 5 : constraints.maxHeight * 0.01),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: isLandscape ? 14 : constraints.maxWidth * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}