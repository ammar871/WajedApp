import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/common/address/bloc/cubit/address_cubit.dart';
import 'package:wajed_app/common/address/ui/addresses_screen/addresses_screen.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/constants/layout/palette.dart';
import '../../../../core/theming/styles.dart';

class SelectAddressOrderWidget extends StatefulWidget {
  const SelectAddressOrderWidget({
    super.key,
  });

  @override
  State<SelectAddressOrderWidget> createState() =>
      _SelectAddressOrderWidgetState();
}

class _SelectAddressOrderWidgetState extends State<SelectAddressOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Text(
            Strings.delivaryTo.tr(),
            style: TextStyles.textStyleFontBold20Black,
          ),
          horizontalSpace(35.w),

          /// drop dawn
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => sl<AddressCubit>(),
                              child: const AddressesScreen(),
                            ))).then((value) {
                  setState(() {});
                });
              },
              child: Container(
                height: 34.w,
                // width: 110.w,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.r),
                    color: Palette.mainColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      currentDefulteAddress != null
                          ? currentDefulteAddress!.name
                          : "",
                      style: TextStyles.textStyleFontBold16White
                          .copyWith(overflow: TextOverflow.ellipsis),
                    )),
                    SvgPicture.asset("assets/images/home/arrow.svg"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
