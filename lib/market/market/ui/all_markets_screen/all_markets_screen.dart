import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/market/data/models/filter_body_request.dart';
import 'package:wajed_app/user/home/data/models/field_model.dart';
import '../../../../core/common_widgets/text_list_empty.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/theming/styles.dart';
import '../../../../user/home/ui/home_screen/comonents/markets_widget.dart';
import '../../bloc/market_cubit/market_cubit.dart';
import 'components/container_radio_widget.dart';

class AllMarketsScreen extends StatefulWidget {
  final FilterBodyRequest filterBodyRequest;
  const AllMarketsScreen({super.key, required this.filterBodyRequest});

  @override
  State<AllMarketsScreen> createState() => _AllMarketsScreenState();
}

class _AllMarketsScreenState extends State<AllMarketsScreen> {
  int page = 1;
  bool filterbyOrder = false;
  bool filterByRate = false;
  bool filterByDicntanc = false;
  int? filedId;
  @override
  void initState() {
    super.initState();
    MarketCubit.get(context).emitFiltersMarkets(widget.filterBodyRequest);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketCubit, MarketState>(
      builder: (ctx, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              Strings.allMarkets,
              style: TextStyles.textStyleFontBold16BlackAppBar,
            ),
            automaticallyImplyLeading: true,
            elevation: 0,
            actions: [
              ///* icon filter
              IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                onPressed: () {
                  ///  * open filter bottom sheet
                  openFilterBottomSheet(ctx);
                },
                icon: Icon(
                  Icons.filter_list_outlined,
                  size: 30.w,
                ),
              )
            ],
          ),
          body: getBody(state),
        );
      },
    );
  }

  Widget getBody(MarketState state) {
    switch (state.getMarketsByFieldIdState) {
      case RequestState.loading:
        return const Center(child: CircularProgressIndicator());
      case RequestState.loaded:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: state.marketResponse!.items.isEmpty
              ? TextListEmpty(text: Strings.noMarkets.tr())
              : MarketsWidget(markets: state.marketResponse!.items),
        );
      case RequestState.error:
        return const Center(child: Text("Error"));
      case RequestState.pagination:
        return const Center(child: Text("pagination"));
    }
  }

  void openFilterBottomSheet(BuildContext ctx) {
    showBottomSheetWidget(ctx, StatefulBuilder(
      builder:
          (BuildContext context, void Function(void Function()) setStateSheet) {
        return Container(
          padding: EdgeInsets.all(30).w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.navigatePop();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 25.w,
                        color: Colors.black,
                      )),
                ],
              ),
              Text(
                Strings.filtterTitle.tr(),
                style: TextStyles.textStyleFontBold20Black,
              ),
              verticalSpace(20.h),

              /// filters by distnatnc
              ContainerRadioWidget(
                title: Strings.neerMarkts.tr(),
                color:
                    filterByDicntanc ? Palette.mainColor : Colors.transparent,
                onChange: () {
                  setStateSheet(() {
                    filterByDicntanc = !filterByDicntanc;
                    print(filterByRate);
                  });
                },
              ),

              /// * most orders
              ContainerRadioWidget(
                title: Strings.filtterbyRate.tr(),
                color: filterbyOrder ? Palette.mainColor : Colors.transparent,
                onChange: () {
                  setStateSheet(() {
                    filterbyOrder = !filterbyOrder;
                    print(filterbyOrder);
                  });
                },
              ),

              /// filters by rate
              ContainerRadioWidget(
                title: Strings.filtterbyOrder.tr(),
                color: filterByRate ? Palette.mainColor : Colors.transparent,
                onChange: () {
                  setStateSheet(() {
                    filterByRate = !filterByRate;
                    print(filterByRate);
                  });
                },
              ),
              verticalSpace(20.h),
              Text(
                Strings.filtterByFiled.tr(),
                style: TextStyles.textStyleFontBold20Black,
              ),
              horizontalSpace(10.h),

              /// * fields
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: fields.length,
                  itemBuilder: (context, index) {
                    FieldModel fieldModel = fields[index];
                    return ContainerRadioWidget(
                      title: isAraic() ? fieldModel.nameAr : fieldModel.nameEng,
                      color: filedId == fieldModel.id
                          ? Palette.mainColor
                          : Colors.transparent,
                      onChange: () {
                        setStateSheet(() {
                          if (filedId == fieldModel.id) {
                            filedId = null;
                          } else {
                            filedId = fieldModel.id;
                          }
                        });
                      },
                    );
                  }),
              verticalSpace(40.h),
              CustomButton(
                  title: Strings.filter.tr(),
                  onPressed: () {
                    context.navigatePop();
                    MarketCubit.get(ctx).emitFiltersMarkets(FilterBodyRequest(
                      page: 1,
                      userId: currentUser!.user.id,
                      fieldId: filedId,
                      byMostOrders: filterbyOrder ? 1 : null,
                      byRate: filterByRate ? 1 : null,
                    ));
                  })
            ],
          ),
        );
      },
    ));
  }
}
