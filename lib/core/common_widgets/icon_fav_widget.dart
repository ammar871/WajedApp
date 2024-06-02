import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/user/favoraite/bloc/favoraite_cubit/favoraite_cubit.dart';
import 'package:wajed_app/user/favoraite/data/models/add_fav_body.dart';
import '../services/services_locator.dart';
import '../utils/app_model.dart';

class IconFavWidget extends StatelessWidget {
  final int marketId;
  const IconFavWidget({super.key, required this.marketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoraiteCubit>(
      create: (context) => sl<FavoraiteCubit>(),
      child: BlocBuilder<FavoraiteCubit, FavoraiteState>(
        builder: (context, state) {
          return IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
              onPressed: () {
                FavoraiteCubit.get(context)
                    .addFavoraites(AddFavBody(currentUser!.user.id, marketId));
              },
              icon: Icon(
                favFound.contains(marketId)
                    ? Icons.favorite
                    : Icons.favorite_border,
                size: 25.w,
                color: Palette.mainColor,
              ));
        },
      ),
    );
  }
}
