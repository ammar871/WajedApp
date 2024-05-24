import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/market/market/data/models/market_model.dart';
import 'package:wajed_app/user/favoraite/bloc/favoraite_cubit/favoraite_cubit.dart';
import '../../../../core/common_widgets/text_list_empty.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/utils/strings.dart';
import '../../../home/ui/home_screen/comonents/markets_widget.dart';

class FavoraitesScreen extends StatelessWidget {
  const FavoraitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoraiteCubit>(
      create: (context) =>
          sl<FavoraiteCubit>()..getFavoraites(userId: currentUser!.user.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.faves,
            style: TextStyles.textStyleFontBold16BlackAppBar,
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
        ),
        body: BlocBuilder<FavoraiteCubit, FavoraiteState>(
          builder: (context, state) {
            switch (state.getFavoraitsState) {
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestState.loaded:
                List<MarketModel> markets = [];
                state.favoraites.forEach((element) {
                  markets.add(element.market);
                });
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: state.favoraites.isEmpty
                      ? TextListEmpty(text: Strings.noMarkets.tr())
                      : ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: markets.length,
                          itemBuilder: (context, index) {
                            return MarketCard(market: markets[index],isFav: true,);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(),
                        ),
                );
              case RequestState.error:
                return const Center(child: Text("Error"));
              case RequestState.pagination:
                return const Center(child: Text("pagination"));
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
