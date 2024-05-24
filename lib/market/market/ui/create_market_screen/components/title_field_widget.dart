import 'package:flutter/material.dart';

import '../../../../../core/theming/styles.dart';

class TitleFieldWidget extends StatelessWidget {
  final String title;
  const TitleFieldWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyles.textStyleFontBold20resturantColor,
        )
      ],
    );
  }
}
