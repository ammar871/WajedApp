import 'package:flutter/material.dart';

import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/theming/styles.dart';

class TextFormCreateMarketWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool? obscureText;
  final Widget? suffixIcon;

  const TextFormCreateMarketWidget(
      {super.key,
      required this.controller,
      required this.hint,
      this.obscureText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Palette.restaurantColor,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Palette.restaurantColor)),
          hintText: hint,
          hintStyle: TextStyles.textStyleFontRegular16greyColor),
    );
  }
}
