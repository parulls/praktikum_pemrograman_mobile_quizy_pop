class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizData {
  static final Map<String, List<Question>> quizzes = {
    'Science': [
      Question(
        question: 'Which planet is known as the Red Planet?',
        options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What is the chemical symbol for water?',
        options: ['O2', 'H2O', 'CO2', 'H2'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What is the largest organ in the human body?',
        options: ['Heart', 'Brain', 'Liver', 'Skin'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'What gas do plants absorb from the atmosphere?',
        options: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the speed of light?',
        options: [
          '300,000 km/s',
          '150,000 km/s',
          '450,000 km/s',
          '200,000 km/s',
        ],
        correctAnswerIndex: 0,
      ),
    ],
    'History': [
      Question(
        question: 'Who was the first President of the United States?',
        options: [
          'Abraham Lincoln',
          'George Washington',
          'Thomas Jefferson',
          'John Adams',
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'In which year did World War II end?',
        options: ['1943', '1944', '1945', '1946'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Who painted the Mona Lisa?',
        options: [
          'Michelangelo',
          'Vincent van Gogh',
          'Leonardo da Vinci',
          'Pablo Picasso',
        ],
        correctAnswerIndex: 2,
      ),
    ],
    'Geography': [
      Question(
        question: 'What is the capital of France?',
        options: ['London', 'Berlin', 'Madrid', 'Paris'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'Which is the largest ocean on Earth?',
        options: [
          'Atlantic Ocean',
          'Indian Ocean',
          'Arctic Ocean',
          'Pacific Ocean',
        ],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'What is the longest river in the world?',
        options: [
          'Amazon River',
          'Nile River',
          'Yangtze River',
          'Mississippi River',
        ],
        correctAnswerIndex: 1,
      ),
    ],
    'Sports': [
      Question(
        question: 'How many players are in a soccer team?',
        options: ['9', '10', '11', '12'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'In which sport would you perform a slam dunk?',
        options: ['Football', 'Basketball', 'Tennis', 'Volleyball'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'How many Grand Slam tournaments are there in tennis?',
        options: ['3', '4', '5', '6'],
        correctAnswerIndex: 1,
      ),
    ],
  };

  static List<Question> getQuestions(String subject) {
    return quizzes[subject] ?? [];
  }
}
