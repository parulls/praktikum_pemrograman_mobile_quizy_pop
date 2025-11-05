import 'dart:async';
import 'package:flutter/material.dart';
import 'package:praktikum_pemrograman_mobile_quizy_pop/models/question_model.dart';
import 'package:praktikum_pemrograman_mobile_quizy_pop/widgets/answer_option_widget.dart';
import 'package:praktikum_pemrograman_mobile_quizy_pop/widgets/quiz_header_widget.dart';
import 'package:praktikum_pemrograman_mobile_quizy_pop/screens/result_screen.dart';

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

class _QuestionScreenState extends State<QuestionScreen> with AutomaticKeepAliveClientMixin {
  late List<Question> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  
  // Menyimpan jawaban user untuk setiap pertanyaan
  late List<int?> _userAnswers;
  late List<bool> _hasAnsweredList;
  
  bool _hasAnswered = false;
  int? _selectedAnswerIndex;
  final List<String> _optionLabels = ['A', 'B', 'C', 'D'];
  
  // Timer variables
  Timer? _timer;
  int _remainingSeconds = 60;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _questions = QuizData.getQuestions(widget.subject);
    _userAnswers = List.filled(_questions.length, null);
    _hasAnsweredList = List.filled(_questions.length, false);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _remainingSeconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timeUp();
        }
      });
    });
  }

  void _timeUp() {
    if (_hasAnswered) return;

    setState(() {
      _hasAnswered = true;
      _hasAnsweredList[_currentQuestionIndex] = true;
      _wrongAnswers++;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      _moveToNextQuestion();
    });
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
      _hasAnsweredList[_currentQuestionIndex] = true;
      _userAnswers[_currentQuestionIndex] = _selectedAnswerIndex;
      
      if (_selectedAnswerIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score += 10;
        _correctAnswers++;
      } else {
        _wrongAnswers++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      _moveToNextQuestion();
    });
  }

  void _moveToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = _userAnswers[_currentQuestionIndex];
        _hasAnswered = _hasAnsweredList[_currentQuestionIndex];
      });
      if (!_hasAnswered) {
        _startTimer();
      } else {
        _timer?.cancel();
      }
    } else {
      _navigateToResult();
    }
  }

  void _moveToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedAnswerIndex = _userAnswers[_currentQuestionIndex];
        _hasAnswered = _hasAnsweredList[_currentQuestionIndex];
      });
      if (!_hasAnswered) {
        _startTimer();
      } else {
        _timer?.cancel();
      }
    } else {
      // Jika di soal pertama, kembali ke SubjectScreen
      _timer?.cancel();
      Navigator.pop(context);
    }
  }

  void _navigateToResult() {
    _timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          score: _score,
          totalQuestions: _questions.length,
          correctAnswers: _correctAnswers,
          wrongAnswers: _wrongAnswers,
          subject: widget.subject,
          userName: widget.userName,
        ),
      ),
    );
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
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final size = MediaQuery.of(context).size;
    final question = _questions[_currentQuestionIndex];

    return WillPopScope(
      onWillPop: () async {
        _moveToPreviousQuestion();
        return false;
      },
      child: Scaffold(
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
                QuizHeaderWidget(
                  subject: widget.subject,
                  currentQuestion: _currentQuestionIndex + 1,
                  totalQuestions: _questions.length,
                  remainingSeconds: _remainingSeconds,
                  onBack: _moveToPreviousQuestion,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.02),
                        _buildQuestionCard(question, size),
                        SizedBox(height: size.height * 0.03),
                        _buildAnswerOptions(question),
                        SizedBox(height: size.height * 0.02),
                        _buildNextButton(size),
                        SizedBox(height: size.height * 0.02),
                      ],
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

  Widget _buildQuestionCard(Question question, Size size) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: size.width * 0.9),
      padding: EdgeInsets.all(size.width * 0.05),
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
            width: size.width * 0.1,
            height: size.width * 0.1,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            decoration: ShapeDecoration(
              color: const Color(0xFF9B34D6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            alignment: Alignment.center,
            child: Text(
              '${_currentQuestionIndex + 1}',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: size.width * 0.025),
          Expanded(
            child: Text(
              question.question,
              style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.05,
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

  Widget _buildNextButton(Size size) {
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;
    
    return GestureDetector(
      onTap: _nextQuestion,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: size.width * 0.9),
        height: size.height * 0.075,
        decoration: BoxDecoration(
          color: const Color(0xFFFF00E5),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLastQuestion ? 'SEE RESULT' : 'NEXT QUESTION',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: size.width * 0.025),
            Icon(
              isLastQuestion ? Icons.emoji_events : Icons.arrow_forward,
              color: Colors.white,
              size: size.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}