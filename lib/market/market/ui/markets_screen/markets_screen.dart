import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/common_widgets/text_list_empty.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';

import 'package:wajed_app/user/home/ui/home_screen/comonents/markets_widget.dart';

import '../../../../core/enums/loading_status.dart';
import '../../../../core/theming/styles.dart';
import '../../bloc/market_cubit/market_cubit.dart';

class MarketsScreen extends StatefulWidget {
  final int fieldId;
  final String title;
  const MarketsScreen({super.key, required this.fieldId, required this.title});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  @override
  void initState() {

    super.initState();
    MarketCubit.get(context).emitGetMarketsByFieldId(
        fieldId: widget.fieldId,
        addressId:
            currentDefulteAddress != null ? currentDefulteAddress!.id : 0,
        page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: BlocBuilder<MarketCubit, MarketState>(
          builder: (context, state) {
            switch (state.getMarketsByFieldIdState) {
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestState.loaded:
                return state.marketResponse!.items.isEmpty
                    ? TextListEmpty(text:Strings.noMarkets.tr())
                    : MarketsWidget(markets: state.marketResponse!.items);
              case RequestState.error:
                return const Center(child: Text("Error"));
              case RequestState.pagination:
                return const Center(child: Text("pagination"));
            }
          },
        ),
      ),
    );
  }
}
