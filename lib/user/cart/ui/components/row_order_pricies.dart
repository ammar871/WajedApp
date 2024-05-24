import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';

import '../../../../core/constants/layout/palette.dart';
import '../../../../core/theming/styles.dart';

class RowOrderPricies extends StatelessWidget {
  final String title;
  final String value;
  const RowOrderPricies({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Palette.kDarkGrey, width: .3))),
      child: Row(
        children: [
          SizedBox(
            width: context.width / 3.5,
            child: Text(
              title,
              style: TextStyles.textStyleFontReqular16kDarkGrey,
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Text(
                value,
                style: TextStyles.textStyleFontBold16greyColor,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
