import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';

class IconBackTrakingWidget extends StatelessWidget {
  const IconBackTrakingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80.h,
      left: 20.w,
      child: InkWell(
        onTap: () {
         context.navigatePop();
        },
        child: Container(
          padding: const EdgeInsets.all(6).w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child:  Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
            size: 20.w,
          ),
        ),
      ),
    );
  }
}

