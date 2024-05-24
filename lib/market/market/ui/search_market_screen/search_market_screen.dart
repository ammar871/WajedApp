import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';


import '../../../../core/common_widgets/home/home_search_bar.dart';
import '../../../../core/common_widgets/text_list_empty.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../user/home/ui/home_screen/comonents/markets_widget.dart';
import '../../bloc/market_cubit/market_cubit.dart';

class SearchMarketScreen extends StatelessWidget {
  const SearchMarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: HomeSearchBar(
          enable: true,
          onChange: (value) {
            MarketCubit.get(context).emitSearchMarkets(
                textSearch: value,
                addressId: currentDefulteAddress != null
                    ? currentDefulteAddress!.id
                    : 0);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30).w,
        child: BlocBuilder<MarketCubit, MarketState>(
          builder: (context, state) {
            switch (state.searchMarketState) {
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestState.loaded:
                return state.markets.isEmpty
                    ? TextListEmpty(text:Strings.noMarkets.tr())
                    : MarketsWidget(markets: state.markets);
              case RequestState.error:
                return const Center(child: Text("Error"));
              case RequestState.pagination:
                return const Center(child: Text("pagination"));
                  default:
        return TextListEmpty(text:Strings.searchToMarket.tr());
            }
          },
        ),
      ),
    );
  }
}
