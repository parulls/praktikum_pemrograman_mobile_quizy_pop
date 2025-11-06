import 'package:flutter/material.dart';
import '../widgets/theme_toggle_widget.dart';
import '../utils/app_theme.dart';
import 'subject_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  bool _visible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    _nameController.dispose();
    _animationController.dispose();
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
      if (mounted) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                SubjectScreen(userName: name),
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
                return Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.1,
                      vertical: constraints.maxHeight * 0.02,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isLandscape ? 600 : 500,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: const ThemeToggleWidget(),
                          ),
                          if (!isLandscape) ...[
                            Image.asset(
                              'assets/images/logo.png',
                              width: constraints.maxWidth * 0.6,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.quiz,
                                  size: constraints.maxWidth * 0.3,
                                  color: Theme.of(context).primaryColor,
                                );
                              },
                            ),
                            SizedBox(height: constraints.maxHeight * 0.02),
                          ],
                          _buildWelcomeCard(constraints),
                          SizedBox(height: constraints.maxHeight * 0.04),
                          _buildNameInput(constraints),
                          SizedBox(height: constraints.maxHeight * 0.03),
                          _buildStartButton(constraints),
                          SizedBox(height: constraints.maxHeight * 0.03),
                          _buildBottomIndicator(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BoxConstraints constraints) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(constraints.maxWidth * 0.05),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.20),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
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
              children: [
                TextSpan(
                  text: 'Welcome to ',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: constraints.maxWidth * 0.065,
                  ),
                ),
                TextSpan(
                  text: 'QuizzyPop',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: constraints.maxWidth * 0.065,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: ' Academy!',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: constraints.maxWidth * 0.065,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          Text(
            'Test Your Knowledge & Shine!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: constraints.maxWidth * 0.045,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameInput(BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight * 0.08,
      constraints: BoxConstraints(
        minHeight: 50,
        maxHeight: 70,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.60),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextField(
            controller: _nameController,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: constraints.maxWidth * 0.045,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Enter Your Name',
              hintStyle: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: constraints.maxHeight * 0.02,
              ),
            ),
            onSubmitted: (_) => _startQuiz(),
          ),
          Positioned(
            left: constraints.maxWidth * 0.06,
            child: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: constraints.maxWidth * 0.05,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BoxConstraints constraints) {
    return GestureDetector(
      onTap: _startQuiz,
      child: Container(
        width: double.infinity,
        height: constraints.maxHeight * 0.08,
        constraints: BoxConstraints(
          minHeight: 50,
          maxHeight: 70,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Theme.of(context).colorScheme.surface),
        ),
        alignment: Alignment.center,
        child: Text(
          'Start Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: constraints.maxWidth * 0.045,
            fontWeight: FontWeight.w500,
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}