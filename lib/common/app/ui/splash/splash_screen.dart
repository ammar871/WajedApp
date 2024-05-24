import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/constants/layout/screen_size.dart';

import '../../../../core/common_widgets/circular_progress.dart';
import '../../../../core/constants/layout/app_assets.dart';
import '../../../../core/constants/layout/app_sizes.dart';
import '../../../../core/services/services_locator.dart';
import '../../bloc/cubit/app_cubit/app_cubit.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // AppCubit.get(context).getPage(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context) => sl<AppCubit>()..getPage(context),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Palette.mainColor,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.getHorizontalPadding(),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: context.hSize * 0.50,
                      child: SvgPicture.asset(
                        AppAssets.logoWhite,
                      ),
                    ),
                    const CustomCircularProgress(color: Palette.white),
                    const SizedBox(height: AppSize.s10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
