import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_option_widget.dart';
import '../widgets/quiz_header_widget.dart';
import 'result_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final List<String> _optionLabels = ['A', 'B', 'C', 'D'];

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop(QuizProvider quizProvider) async {
    if (quizProvider.currentQuestionIndex == 0) {
      if (!mounted) return false;
      
      final shouldExit = await showDialog<bool>(
        context: context,
        builder: (context) => _buildExitDialog(),
      );

      if (shouldExit == true && mounted) {
        return true;
      }
      return false;
    } else {
      quizProvider.moveToPreviousQuestion();
      return false;
    }
  }

  Widget _buildExitDialog() {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        'Exit Quiz?',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
      content: Text(
        'Are you sure you want to exit? Your progress will be lost.',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (mounted) {
              Navigator.of(context).pop(false);
            }
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (mounted) {
              Navigator.of(context).pop(true);
            }
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          child: const Text('Exit'),
        ),
      ],
    );
  }

  void _handleNextQuestion(QuizProvider quizProvider) {
    if (!quizProvider.hasAnswered) {
      if (quizProvider.selectedAnswerIndex == null) {
        _showSnackBar('Please select an answer!');
        return;
      }

      quizProvider.submitAnswer();
    }

    if (quizProvider.currentQuestionIndex < quizProvider.totalQuestions - 1) {
      quizProvider.moveToNextQuestion();
    } else {
      _navigateToResult(quizProvider);
    }
  }

  void _handleSubmit(QuizProvider quizProvider) async {
    final unansweredCount = quizProvider.userAnswers
        .where((answer) => answer == null)
        .length;

    if (unansweredCount > 0) {
      if (!mounted) return;
      
      final shouldSubmit = await showDialog<bool>(
        context: context,
        builder: (context) => _buildSubmitDialog(unansweredCount),
      );

      if (shouldSubmit != true) return;
    }

    if (!quizProvider.hasAnswered && quizProvider.selectedAnswerIndex != null) {
      quizProvider.submitAnswer();
      await Future.delayed(const Duration(milliseconds: 500));
    }

    if (mounted) {
      _navigateToResult(quizProvider);
    }
  }

  Widget _buildSubmitDialog(int unansweredCount) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        'Submit Quiz?',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
      content: Text(
        'You have $unansweredCount unanswered question(s). '
            'Do you want to submit anyway?',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (mounted) {
              Navigator.of(context).pop(false);
            }
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (mounted) {
              Navigator.of(context).pop(true);
            }
          },
          child: Text(
            'Submit',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToResult(QuizProvider quizProvider) {
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const ResultScreen(),
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

  void _showSnackBar(String message) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (quizProvider.remainingSeconds == 0 && !quizProvider.hasAnswered) {
          Future.microtask(() {
            if (!mounted) return;
            _showSnackBar('Time\'s up!');
            Future.delayed(const Duration(seconds: 1), () {
              if (!mounted) return;
              if (quizProvider.currentQuestionIndex < quizProvider.totalQuestions - 1) {
                quizProvider.moveToNextQuestion();
              } else {
                _navigateToResult(quizProvider);
              }
            });
          });
        }

        final question = quizProvider.questions[quizProvider.currentQuestionIndex];

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            final shouldPop = await _onWillPop(quizProvider);
            if (shouldPop && mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            body: OrientationBuilder(
              builder: (context, orientation) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isLandscape = orientation == Orientation.landscape;

                    return Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: _getGradientColors(),
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            QuizHeaderWidget(
                              subject: quizProvider.subject,
                              currentQuestion: quizProvider.currentQuestionIndex + 1,
                              totalQuestions: quizProvider.totalQuestions,
                              remainingSeconds: quizProvider.remainingSeconds,
                              progress: quizProvider.progress,
                              percentageComplete: quizProvider.percentageComplete,
                              onBack: () async {
                                final shouldPop = await _onWillPop(quizProvider);
                                if (shouldPop && mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              onQuestionTap: (index) =>
                                  quizProvider.jumpToQuestion(index),
                              hasAnsweredList: quizProvider.hasAnsweredList,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isLandscape ? 20 : constraints.maxWidth * 0.05,
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: isLandscape ? 900 : 600,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: isLandscape ? 10 : constraints.maxHeight * 0.02),
                                      _buildQuestionCard(
                                        question.question,
                                        quizProvider.currentQuestionIndex + 1,
                                        quizProvider.totalQuestions,
                                        constraints,
                                        isLandscape,
                                      ),
                                      SizedBox(height: isLandscape ? 15 : constraints.maxHeight * 0.03),
                                      _buildAnswerOptions(
                                        question,
                                        quizProvider,
                                        constraints,
                                      ),
                                      SizedBox(height: isLandscape ? 10 : constraints.maxHeight * 0.02),
                                      _buildActionButtons(
                                        quizProvider,
                                        constraints,
                                        isLandscape,
                                      ),
                                      SizedBox(height: isLandscape ? 10 : constraints.maxHeight * 0.02),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  List<Color> _getGradientColors() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      return const [
        Color(0xFF2A1A2A),
        Color(0xFF3A2A3A),
        Color(0xFF4A2A4A),
        Color(0xFF5A2A5A),
      ];
    } else {
      return const [
        Color(0xFFFFF5EE),
        Color(0xFFFAE6FF),
        Color(0xFFF9CDF7),
        Color(0xFFFFAAE7),
      ];
    }
  }

  Widget _buildQuestionCard(
      String questionText,
      int questionNumber,
      int totalQuestions,
      BoxConstraints constraints,
      bool isLandscape,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isLandscape ? 15 : constraints.maxWidth * 0.04),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question $questionNumber of $totalQuestions',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: isLandscape
                  ? 14
                  : (constraints.maxWidth * 0.04).clamp(14.0, 16.0),
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: isLandscape ? 8 : constraints.maxHeight * 0.01),
          Text(
            questionText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: isLandscape
                  ? 15
                  : (constraints.maxWidth * 0.045).clamp(16.0, 20.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions(dynamic question, QuizProvider quizProvider, BoxConstraints constraints) {
    return Column(
      children: List.generate(
        question.options.length,
            (index) {
          bool? isCorrect;

          return OptionButtonWidget(
            label: _optionLabels[index],
            text: question.options[index],
            isSelected: quizProvider.selectedAnswerIndex == index,
            isCorrect: isCorrect,
            onTap: () => quizProvider.selectAnswer(index),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons(QuizProvider quizProvider, BoxConstraints constraints, bool isLandscape) {
    final isLastQuestion = quizProvider.currentQuestionIndex == quizProvider.totalQuestions - 1;

    if (isLastQuestion) {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _handleSubmit(quizProvider),
              child: Container(
                height: isLandscape ? 50 : (constraints.maxHeight * 0.075).clamp(50.0, 70.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: isLandscape ? 20 : (constraints.maxWidth * 0.05).clamp(20.0, 24.0),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.02),
                    Text(
                      'SUBMIT QUIZ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isLandscape ? 16 : (constraints.maxWidth * 0.04).clamp(16.0, 20.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _handleNextQuestion(quizProvider),
            child: Container(
              height: isLandscape ? 50 : (constraints.maxHeight * 0.075).clamp(50.0, 70.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NEXT QUESTION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isLandscape ? 16 : (constraints.maxWidth * 0.04).clamp(16.0, 20.0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: constraints.maxWidth * 0.02),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: isLandscape ? 20 : (constraints.maxWidth * 0.05).clamp(20.0, 24.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}