import 'package:flutter/material.dart';

class OptionButtonWidget extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback onTap;

  const OptionButtonWidget({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color backgroundColor = isDark 
        ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.7)
        : Colors.white.withValues(alpha:0.70);
    Color borderColor = const Color(0xFFFFAAE7);
    Color labelBgColor = const Color(0x3FFFAAE7);
    Color textColor = Theme.of(context).textTheme.bodyLarge!.color!;

    if (isCorrect != null) {
      if (isCorrect!) {
        backgroundColor = const Color(0xFF93FFAE);
        borderColor = const Color(0xFF2ECC71);
        labelBgColor = Colors.white;
        textColor = Colors.black;
      } else if (isSelected) {
        backgroundColor = const Color(0xFFFF93C7);
        borderColor = const Color(0xFFE74C3C);
        labelBgColor = Colors.white;
        textColor = Colors.black;
      }
    } else if (isSelected) {
      backgroundColor = const Color(0xFFFF0088).withValues(alpha:0.1);
      borderColor = const Color(0xFFFF0088);
      labelBgColor = const Color(0xFFFF0088).withValues(alpha:0.3);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final buttonHeight = (size.height * 0.075).clamp(50.0, 70.0);
        final fontSize = (size.width * 0.045).clamp(16.0, 20.0);
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: constraints.maxWidth,
          height: buttonHeight,
          margin: EdgeInsets.only(bottom: size.height * 0.015),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isCorrect == null ? onTap : null,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.01,
                ),
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
                      width: buttonHeight * 0.5,
                      height: buttonHeight * 0.5,
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: fontSize * 0.9,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}