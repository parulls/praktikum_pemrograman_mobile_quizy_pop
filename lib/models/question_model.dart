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
      Question(
        question: 'What is the center of an atom called?',
        options: ['Electron', 'Proton', 'Nucleus', 'Neutron'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'How many bones are in the adult human body?',
        options: ['186', '206', '226', '246'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What is the hardest natural substance on Earth?',
        options: ['Gold', 'Iron', 'Diamond', 'Platinum'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What type of animal is a dolphin?',
        options: ['Fish', 'Mammal', 'Reptile', 'Amphibian'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What is the boiling point of water?',
        options: ['90°C', '100°C', '110°C', '120°C'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Which gas makes up most of Earth\'s atmosphere?',
        options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the smallest unit of life?',
        options: ['Atom', 'Molecule', 'Cell', 'Organ'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'How many teeth does an adult human have?',
        options: ['28', '30', '32', '34'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the process by which plants make food?',
        options: ['Respiration', 'Photosynthesis', 'Digestion', 'Absorption'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What is the largest planet in our solar system?',
        options: ['Saturn', 'Neptune', 'Jupiter', 'Uranus'],
        correctAnswerIndex: 2,
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
      Question(
        question: 'In which year did Christopher Columbus discover America?',
        options: ['1492', '1500', '1488', '1510'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'Who was the first man to walk on the moon?',
        options: [
          'Buzz Aldrin',
          'Neil Armstrong',
          'Yuri Gagarin',
          'John Glenn',
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What ancient wonder was located in Alexandria?',
        options: [
          'Hanging Gardens',
          'Colossus',
          'Lighthouse',
          'Pyramid',
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Who wrote "Romeo and Juliet"?',
        options: [
          'Charles Dickens',
          'William Shakespeare',
          'Mark Twain',
          'Jane Austen',
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'In which year did the Berlin Wall fall?',
        options: ['1987', '1988', '1989', '1990'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Who was the first woman to win a Nobel Prize?',
        options: [
          'Marie Curie',
          'Mother Teresa',
          'Rosa Parks',
          'Florence Nightingale',
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'What year did the Titanic sink?',
        options: ['1910', '1911', '1912', '1913'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Who was the longest-reigning British monarch?',
        options: [
          'Queen Victoria',
          'Queen Elizabeth II',
          'King George III',
          'King Henry VIII',
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'In which year did World War I begin?',
        options: ['1912', '1913', '1914', '1915'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Who invented the telephone?',
        options: [
          'Thomas Edison',
          'Nikola Tesla',
          'Alexander Graham Bell',
          'Guglielmo Marconi',
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What was the ancient name of Istanbul?',
        options: ['Athens', 'Sparta', 'Constantinople', 'Alexandria'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Who was the first Emperor of Rome?',
        options: [
          'Julius Caesar',
          'Augustus',
          'Nero',
          'Constantine',
        ],
        correctAnswerIndex: 1,
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
      Question(
        question: 'What is the smallest country in the world?',
        options: ['Monaco', 'Vatican City', 'San Marino', 'Liechtenstein'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Which continent is the Sahara Desert located in?',
        options: ['Asia', 'Australia', 'Africa', 'South America'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Japan?',
        options: ['Seoul', 'Beijing', 'Tokyo', 'Bangkok'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'How many continents are there?',
        options: ['5', '6', '7', '8'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the highest mountain in the world?',
        options: ['K2', 'Mount Everest', 'Kilimanjaro', 'Mont Blanc'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Which country has the largest population?',
        options: ['India', 'United States', 'China', 'Indonesia'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the largest country by area?',
        options: ['Canada', 'China', 'United States', 'Russia'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'Which ocean is Bermuda Triangle located in?',
        options: [
          'Pacific Ocean',
          'Atlantic Ocean',
          'Indian Ocean',
          'Arctic Ocean',
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which river flows through Egypt?',
        options: ['Amazon', 'Nile', 'Tigris', 'Euphrates'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What is the largest island in the world?',
        options: ['Borneo', 'Madagascar', 'Greenland', 'New Guinea'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'Japan', 'Thailand', 'South Korea'],
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
      Question(
        question: 'What is the diameter of a basketball hoop in inches?',
        options: ['16', '18', '20', '22'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'How many points is a touchdown worth in American football?',
        options: ['5', '6', '7', '8'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'In which sport do you use a shuttlecock?',
        options: ['Tennis', 'Squash', 'Badminton', 'Table Tennis'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'How many players are on a baseball team on the field?',
        options: ['8', '9', '10', '11'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What is the maximum score in a single frame of bowling?',
        options: ['10', '20', '30', '40'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'How long is an Olympic swimming pool?',
        options: ['25 meters', '50 meters', '75 meters', '100 meters'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'In golf, what is one stroke under par called?',
        options: ['Eagle', 'Birdie', 'Bogey', 'Albatross'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'How many rings are on the Olympic flag?',
        options: ['4', '5', '6', '7'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'What is the highest belt in Karate?',
        options: ['Red', 'Black', 'White', 'Brown'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'How many sets do you need to win a tennis match?',
        options: ['1', '2', '3', '4'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the distance of a marathon?',
        options: [
          '26.2 miles',
          '30 miles',
          '20 miles',
          '25 miles',
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'In cricket, how many players are on each team?',
        options: ['9', '10', '11', '12'],
        correctAnswerIndex: 2,
      ),
    ],
  };

  static List<Question> getQuestions(String subject) {
    return quizzes[subject] ?? [];
  }
}