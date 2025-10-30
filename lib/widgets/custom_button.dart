import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? contentPadding;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menggunakan tema untuk warna default jika tidak disediakan
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity, // Tombol memenuhi lebar yang tersedia
      height: 65, // Tinggi tetap untuk tombol
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorScheme.primary,
          foregroundColor: textColor ?? colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Sudut membulat
          ),
          elevation: 5,
          padding: contentPadding ?? EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}