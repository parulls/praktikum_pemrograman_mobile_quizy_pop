import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizProvider with ChangeNotifier {
  late List<Question> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  List<int?> _userAnswers = [];
  List<bool> _hasAnsweredList = [];
  List<int> _timeSpentList = [];
  bool _hasAnswered = false;
  int? _selectedAnswerIndex;
  Timer? _timer;
  int _remainingSeconds = 30;
  String _subject = '';
  String _userName = '';

  // Getters
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;
  List<int?> get userAnswers => _userAnswers;
  List<bool> get hasAnsweredList => _hasAnsweredList;
  List<int> get timeSpentList => _timeSpentList;
  bool get hasAnswered => _hasAnswered;
  int? get selectedAnswerIndex => _selectedAnswerIndex;
  int get remainingSeconds => _remainingSeconds;
  String get subject => _subject;
  String get userName => _userName;
  int get totalQuestions => _questions.length;
  double get progress => (_currentQuestionIndex + 1) / _questions.length;
  double get percentageComplete => ((_currentQuestionIndex + 1) / _questions.length) * 100;

  void initializeQuiz(String subject, String userName) {
    _subject = subject;
    _userName = userName;
    _questions = QuizData.getQuestions(subject);
    _currentQuestionIndex = 0;
    _score = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _userAnswers = List.filled(_questions.length, null);
    _hasAnsweredList = List.filled(_questions.length, false);
    _timeSpentList = List.filled(_questions.length, 0);
    _hasAnswered = false;
    _selectedAnswerIndex = null;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _remainingSeconds = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        _timeUp();
      }
    });
  }

  void _timeUp() {
    if (_hasAnswered) return;
    
    _hasAnswered = true;
    _hasAnsweredList[_currentQuestionIndex] = true;
    _wrongAnswers++;
    _timeSpentList[_currentQuestionIndex] = 30;
    notifyListeners();
  }

  void selectAnswer(int index) {
    if (_hasAnswered) return;
    _selectedAnswerIndex = index;
    notifyListeners();
  }

  bool submitAnswer() {
    if (_selectedAnswerIndex == null) {
      return false;
    }

    _hasAnswered = true;
    _hasAnsweredList[_currentQuestionIndex] = true;
    _userAnswers[_currentQuestionIndex] = _selectedAnswerIndex;
    _timeSpentList[_currentQuestionIndex] = 30 - _remainingSeconds;
    
    if (_selectedAnswerIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
      _score += 10;
      _correctAnswers++;
    } else {
      _wrongAnswers++;
    }
    
    notifyListeners();
    return true;
  }

  void moveToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _selectedAnswerIndex = _userAnswers[_currentQuestionIndex];
      _hasAnswered = _hasAnsweredList[_currentQuestionIndex];
      
      if (!_hasAnswered) {
        _startTimer();
      } else {
        _timer?.cancel();
      }
      notifyListeners();
    }
  }

  void moveToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _selectedAnswerIndex = _userAnswers[_currentQuestionIndex];
      _hasAnswered = _hasAnsweredList[_currentQuestionIndex];
      
      if (!_hasAnswered) {
        _startTimer();
      } else {
        _timer?.cancel();
      }
      notifyListeners();
    }
  }

  void jumpToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentQuestionIndex = index;
      _selectedAnswerIndex = _userAnswers[_currentQuestionIndex];
      _hasAnswered = _hasAnsweredList[_currentQuestionIndex];
      
      if (!_hasAnswered) {
        _startTimer();
      } else {
        _timer?.cancel();
      }
      notifyListeners();
    }
  }

  double getAverageTimePerQuestion() {
    int answeredQuestions = _hasAnsweredList.where((answered) => answered).length;
    if (answeredQuestions == 0) return 0;
    
    int totalTime = _timeSpentList.reduce((a, b) => a + b);
    return totalTime / answeredQuestions;
  }

  double getAccuracyPercentage() {
    int totalAnswered = _correctAnswers + _wrongAnswers;
    if (totalAnswered == 0) return 0;
    return (_correctAnswers / totalAnswered) * 100;
  }

  String getBadge() {
    double accuracy = getAccuracyPercentage();
    double avgTime = getAverageTimePerQuestion();
    
    if (accuracy == 100) {
      return 'Perfect Score! 🏆';
    } else if (accuracy >= 80 && avgTime < 15) {
      return 'Fast Thinker! ⚡';
    } else if (accuracy >= 80) {
      return 'Quiz Master! 🎓';
    } else if (accuracy >= 60) {
      return 'Good Job! 👍';
    } else {
      return 'Keep Practicing! 💪';
    }
  }

  void resetQuiz() {
    _timer?.cancel();
    _currentQuestionIndex = 0;
    _score = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _userAnswers = List.filled(_questions.length, null);
    _hasAnsweredList = List.filled(_questions.length, false);
    _timeSpentList = List.filled(_questions.length, 0);
    _hasAnswered = false;
    _selectedAnswerIndex = null;
    _startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}