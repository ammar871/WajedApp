import 'package:flutter/material.dart';
import 'package:wajed_app/core/constants/layout/app_fonts.dart';

class TextListEmpty extends StatelessWidget {
  final String text;
  final Color? textColor;
  const TextListEmpty({super.key, required this.text,  this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontSize: 18,
          fontFamily: AppFonts.stc,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
