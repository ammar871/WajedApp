import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/home/data/models/home_market_response.dart';
import '../../../../../core/helpers/spacing.dart';
import 'expaned_counter_widget.dart';

class ContersDetailsWidget extends StatelessWidget {
  final HomeResponseMarket homeResponseMarket;
  const ContersDetailsWidget({super.key, required this.homeResponseMarket});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// * walet
        ExpanedCounterWidget(
          title:Strings.monyDelvary.tr(),
          value: homeResponseMarket.data!.receipts.toStringAsFixed(1),
          colors: const [Color(0xffee9ca7), Color(0xffffdde1)],
        ),
        horizontalSpace(10.w),
        ExpanedCounterWidget(
          title: Strings.succedfulOrders.tr(),
          value: homeResponseMarket.data!.successfulOrders.toString(),
          colors: const [Color(0xffa8e5fb), Color(0xff2980b9)],
        ),
        horizontalSpace(10.w),
        ExpanedCounterWidget(
          title:Strings.unSuccessOrders.tr(),
          value: homeResponseMarket.data!.otherOrders.toString(),
          colors: const [Color(0xffc6ffdd), Color(0xfffbd786)],
        ),
      ],
    );
  }
}
