import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_theme.dart';

class ReviewAnswerScreen extends StatelessWidget {
  const ReviewAnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppTheme.getGradientColors(context),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: quizProvider.questions.length,
                      itemBuilder: (context, index) {
                        final question = quizProvider.questions[index];
                        final userAnswerIndex = quizProvider.userAnswers[index];
                        final isCorrect = userAnswerIndex == question.correctAnswerIndex;

                        return _buildQuestionCard(
                          context,
                          index + 1,
                          question,
                          userAnswerIndex,
                          isCorrect,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Review Answers',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(
      BuildContext context,
      int questionNumber,
      dynamic question,
      int? userAnswerIndex,
      bool isCorrect,
      ) {
    final labels = ['A', 'B', 'C', 'D'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
          // Question header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  color: isCorrect ? const Color(0xFF2BA855) : const Color(0xFFDC2828),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$questionNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  question.question,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? const Color(0xFF2BA855) : const Color(0xFFDC2828),
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Options
          ...List.generate(question.options.length, (index) {
            final isUserAnswer = index == userAnswerIndex;
            final isCorrectAnswer = index == question.correctAnswerIndex;

            Color backgroundColor = Theme.of(context).colorScheme.surface;
            Color borderColor = const Color(0xFFE0E0E0);

            if (isCorrectAnswer) {
              backgroundColor = const Color(0xFF93FFAE);
              borderColor = const Color(0xFF2BA855);
            } else if (isUserAnswer && !isCorrect) {
              backgroundColor = const Color(0xFFFF93C7);
              borderColor = const Color(0xFFDC2828);
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: borderColor, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isCorrectAnswer || (isUserAnswer && !isCorrect)
                          ? Colors.white
                          : const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      labels[index],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question.options[index],
                      style: TextStyle(
                        color: isCorrectAnswer || (isUserAnswer && !isCorrect)
                            ? Colors.black
                            : Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (isCorrectAnswer)
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF2BA855),
                      size: 24,
                    ),
                  if (isUserAnswer && !isCorrect)
                    const Icon(
                      Icons.cancel,
                      color: Color(0xFFDC2828),
                      size: 24,
                    ),
                ],
              ),
            );
          }),

          // Status message
          if (userAnswerIndex == null)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFFFF8800),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Not answered',
                    style: TextStyle(
                      color: const Color(0xFFFF8800),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}