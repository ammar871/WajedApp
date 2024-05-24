import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/common/address/bloc/cubit/address_cubit.dart';
import 'package:wajed_app/common/address/ui/addresses_screen/addresses_screen.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/user/cart/bloc/cart_cubit/cart_cubit.dart';

import 'package:wajed_app/user/cart/ui/cart_screen/cart_screen.dart';
import 'package:wajed_app/user/home/bloc/home_cubit/home_cubit.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/theming/styles.dart';

class AppBarHomeWidget extends StatefulWidget {
  final void Function() onPressed;
  const AppBarHomeWidget({
    super.key, required this.onPressed,
  });

  @override
  State<AppBarHomeWidget> createState() => _AppBarHomeWidgetState();
}

class _AppBarHomeWidgetState extends State<AppBarHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                height: 43.w,
                width: 43.w,
                padding: const EdgeInsets.all(10).w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.r),
                    color: Palette.mainColor),
                child: SvgPicture.asset("assets/images/home/menu_ic.svg"),
              ),
            )

            ///
            ,
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => sl<AddressCubit>(),
                            child: const AddressesScreen(),
                          )),
                ).then((value) {
                  setState(() {});
                });
              },
              child: Row(
                children: [
                  Text(
                    Strings.delivaryTo.tr(),
                    style: TextStyles.textStyleFontBold20Black,
                  ),
                  horizontalSpace(15.w),

                  /// drop dawn
                  Container(
                    height: 34.w,
                    width: 110.w,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
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
                  MaterialButton(
                    minWidth: 40.w,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.navigatePush(BlocProvider(
                        create: (context) => sl<CartCubit>(),
                        child: const CartScreen(),
                      ));
                    },
                    child: SvgPicture.asset("assets/images/home/cart.svg"),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
