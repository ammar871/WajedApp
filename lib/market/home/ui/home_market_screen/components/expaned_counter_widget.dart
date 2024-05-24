import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/styles.dart';

class ExpanedCounterWidget extends StatelessWidget {
  final String title, value;
  final List<Color> colors;
  const ExpanedCounterWidget({
    super.key,
    required this.title,
    required this.value,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          gradient: LinearGradient(
            begin: const Alignment(-0.9, -0.97),
            end: const Alignment(0.91, 0.92),
            colors: colors,
            stops: const [0.0, 1.0],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4d000000),
              offset: Offset(3, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyles.textStyleFontBold12kDarkGrey,
            ),
            Text(
              value,
              style: TextStyles.textStyleFontBold37kDarkGrey,
            )
          ],
        ),
      ),
    );
  }
}
