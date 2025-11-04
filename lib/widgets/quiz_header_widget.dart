import 'package:flutter/material.dart';

class QuizHeaderWidget extends StatelessWidget {
  final String subject;
  final int currentQuestion;
  final int totalQuestions;
  final int remainingSeconds;
  final VoidCallback onBack;

  const QuizHeaderWidget({
    super.key,
    required this.subject,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.remainingSeconds,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentQuestion / totalQuestions;
    final subjectTitle = '${subject[0].toUpperCase()}${subject.substring(1)} Quiz';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header bar: back button, subject name, timer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                    splashRadius: 24,
                  ),
                  Text(
                    subjectTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.timer, color: Color(0xFFFF0088), size: 20),
                  const SizedBox(width: 4),
                  Text(
                    _formatTime(remainingSeconds),
                    style: const TextStyle(
                      color: Color(0xFFFF0088),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Progress bar di bawah header
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8F51),
                    borderRadius: BorderRadius.circular(24),
                  ),
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
}
