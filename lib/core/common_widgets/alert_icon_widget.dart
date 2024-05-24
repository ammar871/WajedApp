import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wajed_app/common/alerts/ui/alerts_screen/alerts_screen.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';

class AlertIconWidget extends StatelessWidget {
  const AlertIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.w,
      minWidth: 40.w,
      padding: EdgeInsets.zero,
      onPressed: () {
        context.navigatePush(const AlertsScreen());
      },
      child: SvgPicture.asset(
        "assets/icons/noty.svg",
        width: 20.w,
        height: 20.w,
      ),
    );
  }
}
