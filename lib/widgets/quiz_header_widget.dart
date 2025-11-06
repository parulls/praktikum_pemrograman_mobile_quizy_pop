import 'package:flutter/material.dart';

class QuizHeaderWidget extends StatelessWidget {
  final String subject;
  final int currentQuestion;
  final int totalQuestions;
  final int remainingSeconds;
  final double progress;
  final double percentageComplete;
  final VoidCallback onBack;
  final Function(int) onQuestionTap;
  final List<bool> hasAnsweredList;

  const QuizHeaderWidget({
    super.key,
    required this.subject,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.remainingSeconds,
    required this.progress,
    required this.percentageComplete,
    required this.onBack,
    required this.onQuestionTap,
    required this.hasAnsweredList,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final subjectTitle = '${subject[0].toUpperCase()}${subject.substring(1)} Quiz';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 16 : size.width * 0.04,
        vertical: isLandscape ? 8 : size.height * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onBack,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        size: isLandscape ? 20 : size.width * 0.06,
                      ),
                      splashRadius: 20,
                    ),
                    Flexible(
                      child: Text(
                        subjectTitle,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: isLandscape ? 16 : size.width * 0.045,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: remainingSeconds <= 10
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                    size: isLandscape ? 18 : size.width * 0.045,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    _formatTime(remainingSeconds),
                    style: TextStyle(
                      color: remainingSeconds <= 10
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                      fontSize: isLandscape ? 14 : size.width * 0.04,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  IconButton(
                    icon: Icon(
                      Icons.grid_view_rounded,
                      color: Theme.of(context).primaryColor,
                      size: isLandscape ? 20 : size.width * 0.055,
                    ),
                    onPressed: () => _showQuestionPreview(context),
                    tooltip: 'View all questions',
                    splashRadius: 20,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: isLandscape ? 6 : size.height * 0.01),

          // Progress bar with percentage
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFF8F51),
                              Color(0xFFFF0088),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: size.width * 0.03),
              Text(
                '${percentageComplete.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: isLandscape ? 12 : size.width * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _showQuestionPreview(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: isLandscape ? size.height * 0.8 : size.height * 0.6,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(isLandscape ? 12 : 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question Overview',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: isLandscape ? 16 : 20,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: isLandscape ? 20 : 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(isLandscape ? 12 : 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isLandscape ? 8 : 5,
                  crossAxisSpacing: isLandscape ? 8 : 10,
                  mainAxisSpacing: isLandscape ? 8 : 10,
                  childAspectRatio: 1,
                ),
                itemCount: totalQuestions,
                itemBuilder: (context, index) {
                  final isAnswered = hasAnsweredList[index];
                  final isCurrent = index == currentQuestion - 1;

                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onQuestionTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? Theme.of(context).primaryColor
                            : isAnswered
                            ? Colors.green.withOpacity(0.7)
                            : Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: isCurrent || isAnswered
                                    ? Colors.white
                                    : Theme.of(context).textTheme.bodyLarge!.color,
                                fontSize: isLandscape ? 14 : 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (isAnswered)
                            Positioned(
                              top: 2,
                              right: 2,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: isLandscape ? 12 : 16,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}