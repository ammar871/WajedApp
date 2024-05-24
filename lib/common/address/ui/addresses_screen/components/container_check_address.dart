
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/helper_functions.dart';

class ContainerCheckAddress extends StatelessWidget {
  final Color color;
  const ContainerCheckAddress({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: 8.w,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                // * arabic
                topRight: isAraic()
                    ? Radius.circular(7.0.r)
                    : const Radius.circular(0),
                bottomRight: isAraic()
                    ? Radius.circular(7.r)
                    : const Radius.circular(0.0),

                /// english
                bottomLeft: isAraic()
                    ? const Radius.circular(0)
                    : Radius.circular(7.0.r),
                topLeft: isAraic()
                    ? const Radius.circular(0)
                    : Radius.circular(7.0.r))));
  }
}
