import 'package:flutter/material.dart';
import 'package:praktikum_pemrograman_mobile_quizy_pop/models/question_model.dart';
import 'package:praktikum_pemrograman_mobile_quizy_pop/widgets/answer_option_widget.dart';

class QuestionScreen extends StatefulWidget {
  final String subject;
  final String userName;

  const QuestionScreen({
    super.key,
    required this.subject,
    required this.userName,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late List<Question> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _hasAnswered = false;
  final List<String> _optionLabels = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    super.initState();
    _questions = QuizData.getQuestions(widget.subject);
  }

  void _selectAnswer(int index) {
    if (_hasAnswered) return;

    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  void _nextQuestion() {
    if (_selectedAnswerIndex == null) {
      _showSnackBar('Please select an answer!');
      return;
    }

    setState(() {
      _hasAnswered = true;
      if (_selectedAnswerIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score += 10;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswerIndex = null;
          _hasAnswered = false;
        });
      } else {
        _navigateToResult();
      }
    });
  }

  void _navigateToResult() {
      //TODO: implement result screen
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFFF0088),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF5EE),
              Color(0xFFFAE6FF),
              Color(0xFFF9CDF7),
              Color(0xFFFFAAE7),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildQuestionCard(question),
                      const SizedBox(height: 30),
                      _buildAnswerOptions(question),
                      const SizedBox(height: 20),
                      _buildNextButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Question question) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
              color: const Color(0xFF9B34D6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            alignment: Alignment.center,
            child: Text(
              '${_currentQuestionIndex + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              question.question,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions(Question question) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        children: List.generate(
          question.options.length,
          (index) {
            bool? isCorrect;
            if (_hasAnswered) {
              // Setelah dijawab, tampilkan status benar/salah untuk semua opsi
              isCorrect = index == question.correctAnswerIndex;
            }
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AnswerOptionWidget(
                label: _optionLabels[index],
                text: question.options[index],
                isSelected: _selectedAnswerIndex == index,
                isCorrect: isCorrect,
                onTap: () => _selectAnswer(index),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: _nextQuestion,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 400),
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFFF00E5),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'NEXT QUESTION',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}