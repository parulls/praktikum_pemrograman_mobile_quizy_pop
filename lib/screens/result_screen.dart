import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final String subject;
  final String userName;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.subject,
    required this.userName,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  String _getResultMessage() {
    final percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
    if (percentage >= 80) return 'Excellent!';
    if (percentage >= 60) return 'Good Job!';
    if (percentage >= 40) return 'Not Bad!';
    return 'Keep Trying!';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
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
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildResultCard(size),
                      SizedBox(height: size.height * 0.03),
                      _buildPlayAgainButton(size),
                      SizedBox(height: size.height * 0.02),
                      _buildHomeButton(size),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(Size size) {
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
      child: Column(
        children: [
          Text(
            'Quiz Complete!',
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Great job, ',
                  style: TextStyle(
                    color: const Color(0xFF505050),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: widget.userName,
                  style: TextStyle(
                    color: const Color(0xFFFF0088),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '!',
                  style: TextStyle(
                    color: const Color(0xFF505050),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          _buildScoreBox(size),
          SizedBox(height: size.height * 0.02),
          _buildStatsRow(size),
        ],
      ),
    );
  }

  Widget _buildScoreBox(Size size) {
    final percentage = ((widget.correctAnswers / widget.totalQuestions) * 100).toStringAsFixed(0);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        color: const Color(0xFFFF0088),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            'Your Score',
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.correctAnswers}',
                style: TextStyle(
                  color: const Color(0xFFE7E7E7),
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                ' / ${widget.totalQuestions}',
                style: TextStyle(
                  color: const Color(0xFFE7E7E7),
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.005),
          Text(
            _getResultMessage(),
            style: TextStyle(
              color: const Color(0xFFE7E7E7),
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(Size size) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  '${widget.correctAnswers}',
                  style: TextStyle(
                    color: const Color(0xFF2BA855),
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Correct',
                  style: TextStyle(
                    color: const Color(0xFF2BA855),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  '${widget.wrongAnswers}',
                  style: TextStyle(
                    color: const Color(0xFFDC2828),
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Wrong',
                  style: TextStyle(
                    color: const Color(0xFFDC2828),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayAgainButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: size.width * 0.9),
        height: size.height * 0.075,
        decoration: BoxDecoration(
          color: const Color(0xFFFF0088),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.replay, color: Colors.white, size: size.width * 0.05),
            SizedBox(width: size.width * 0.025),
            Text(
              'PLAY AGAIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: size.width * 0.9),
        height: size.height * 0.075,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: const Color(0xFFFF0088), width: 2),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, color: const Color(0xFFFF0088), size: size.width * 0.05),
            SizedBox(width: size.width * 0.025),
            Text(
              'BACK TO HOME',
              style: TextStyle(
                color: const Color(0xFFFF0088),
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}