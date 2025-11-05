import 'package:flutter/material.dart';

class AnswerOptionWidget extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback onTap;

  const AnswerOptionWidget({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white.withValues(alpha: 0.70);
    Color borderColor = const Color(0xFFFFAAE7);
    Color labelBgColor = const Color(0x3FFFAAE7);
    Color textColor = Colors.black;

    if (isCorrect != null) {
      if (isCorrect!) {
        backgroundColor = const Color(0xFF93FFAE);
        borderColor = const Color(0xFF2ECC71);
        labelBgColor = Colors.white;
        textColor = Colors.white;
      } else if (isSelected) {
        backgroundColor = const Color(0xFFFF93C7);
        borderColor = const Color(0xFFE74C3C);
        labelBgColor = Colors.white;
        textColor = Colors.white;
      }
    } else if (isSelected) {
      backgroundColor = const Color(0xFFFF0088).withValues(alpha: 0.1);
      borderColor = const Color(0xFFFF0088);
      labelBgColor = const Color(0xFFFF0088).withValues(alpha: 0.3);
    }

    return GestureDetector(
      onTap: isCorrect == null ? onTap : null,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: borderColor),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                color: labelBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}