import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_theme.dart';
import 'review_answer_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  bool _visible = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
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

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: OrientationBuilder(
              builder: (context, orientation) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: AppTheme.getGradientColors(context),
                        ),
                      ),
                      child: SafeArea(
                        child: AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          child: Center(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.05,
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: orientation == Orientation.landscape
                                      ? 800
                                      : 500,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ScaleTransition(
                                      scale: _scaleAnimation,
                                      child: _buildResultCard(
                                        quizProvider,
                                        constraints,
                                      ),
                                    ),
                                    SizedBox(height: constraints.maxHeight * 0.03),
                                    _buildReviewButton(
                                      quizProvider,
                                      constraints,
                                    ),
                                    SizedBox(height: constraints.maxHeight * 0.02),
                                    _buildPlayAgainButton(
                                      quizProvider,
                                      constraints,
                                    ),
                                    SizedBox(height: constraints.maxHeight * 0.02),
                                    _buildHomeButton(constraints),
                                    SizedBox(height: constraints.maxHeight * 0.02),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultCard(QuizProvider quizProvider, BoxConstraints constraints) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(constraints.maxWidth * 0.05),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.emoji_events,
            color: Theme.of(context).primaryColor,
            size: constraints.maxWidth * 0.15,
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          Text(
            'Quiz Complete!',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: (constraints.maxWidth * 0.06).clamp(20.0, 28.0),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.01),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Great job, ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: quizProvider.userName,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: (constraints.maxWidth * 0.04).clamp(14.0, 18.0),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '!',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          _buildScoreBox(quizProvider, constraints),
          SizedBox(height: constraints.maxHeight * 0.02),
          _buildStatsGrid(quizProvider, constraints),
          SizedBox(height: constraints.maxHeight * 0.02),
          _buildBadge(quizProvider, constraints),
        ],
      ),
    );
  }

  Widget _buildScoreBox(QuizProvider quizProvider, BoxConstraints constraints) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(constraints.maxWidth * 0.05),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            'Your Score',
            style: TextStyle(
              color: Colors.white,
              fontSize: (constraints.maxWidth * 0.035).clamp(12.0, 16.0),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${quizProvider.correctAnswers}',
                style: TextStyle(
                  color: const Color(0xFFE7E7E7),
                  fontSize: (constraints.maxWidth * 0.1).clamp(32.0, 48.0),
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                ' / ${quizProvider.totalQuestions}',
                style: TextStyle(
                  color: const Color(0xFFE7E7E7),
                  fontSize: (constraints.maxWidth * 0.05).clamp(18.0, 24.0),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(QuizProvider quizProvider, BoxConstraints constraints) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                '${quizProvider.correctAnswers}',
                'Correct',
                const Color(0xFF2BA855),
                const Color(0xFFF0FDF4),
                constraints,
              ),
            ),
            SizedBox(width: constraints.maxWidth * 0.03),
            Expanded(
              child: _buildStatCard(
                '${quizProvider.wrongAnswers}',
                'Wrong',
                const Color(0xFFDC2828),
                const Color(0xFFFEF2F2),
                constraints,
              ),
            ),
          ],
        ),
        SizedBox(height: constraints.maxHeight * 0.02),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                '${quizProvider.getAccuracyPercentage().toStringAsFixed(0)}%',
                'Accuracy',
                const Color(0xFF0088FF),
                const Color(0xFFE6F3FF),
                constraints,
              ),
            ),
            SizedBox(width: constraints.maxWidth * 0.03),
            Expanded(
              child: _buildStatCard(
                '${quizProvider.getAverageTimePerQuestion().toStringAsFixed(0)}s',
                'Avg Time',
                const Color(0xFFFF8800),
                const Color(0xFFFFF3E6),
                constraints,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String value,
      String label,
      Color textColor,
      Color bgColor,
      BoxConstraints constraints,
      ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.025),
      decoration: BoxDecoration(
        color: isDark ? textColor.withOpacity(0.2) : bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: (constraints.maxWidth * 0.06).clamp(20.0, 28.0),
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: (constraints.maxWidth * 0.035).clamp(12.0, 16.0),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(QuizProvider quizProvider, BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.04,
        vertical: constraints.maxHeight * 0.015,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        quizProvider.getBadge(),
        style: TextStyle(
          color: Colors.white,
          fontSize: (constraints.maxWidth * 0.04).clamp(14.0, 18.0),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildReviewButton(QuizProvider quizProvider, BoxConstraints constraints) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ReviewAnswerScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: (constraints.maxHeight * 0.075).clamp(50.0, 70.0),
        decoration: BoxDecoration(
          color: const Color(0xFF9B34D6),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rate_review,
              color: Colors.white,
              size: (constraints.maxWidth * 0.05).clamp(20.0, 24.0),
            ),
            SizedBox(width: constraints.maxWidth * 0.025),
            Text(
              'REVIEW ANSWERS',
              style: TextStyle(
                color: Colors.white,
                fontSize: (constraints.maxWidth * 0.045).clamp(16.0, 20.0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayAgainButton(QuizProvider quizProvider, BoxConstraints constraints) {
    return GestureDetector(
      onTap: () {
        quizProvider.resetQuiz();
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        height: (constraints.maxHeight * 0.075).clamp(50.0, 70.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.replay,
              color: Colors.white,
              size: (constraints.maxWidth * 0.05).clamp(20.0, 24.0),
            ),
            SizedBox(width: constraints.maxWidth * 0.025),
            Text(
              'PLAY AGAIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: (constraints.maxWidth * 0.045).clamp(16.0, 20.0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(BoxConstraints constraints) {
    return GestureDetector(
      onTap: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Container(
        width: double.infinity,
        height: (constraints.maxHeight * 0.075).clamp(50.0, 70.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
              size: (constraints.maxWidth * 0.05).clamp(20.0, 24.0),
            ),
            SizedBox(width: constraints.maxWidth * 0.025),
            Text(
              'BACK TO HOME',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: (constraints.maxWidth * 0.045).clamp(16.0, 20.0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}