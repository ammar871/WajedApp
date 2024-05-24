import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/common/address/ui/addresses_screen/components/container_check_address.dart';
import 'package:wajed_app/common/alerts/bloc/cubit/alerts_cubit.dart';
import 'package:wajed_app/common/alerts/ui/alert_details_screen/alert_details_screen.dart';
import 'package:wajed_app/common/chate/ui/conversations_screen/conversations_screen.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/common/order/ui/order_details_market_screenn/order_details_market_screenn.dart';
import 'package:wajed_app/common/order/ui/order_details_screen/order_details_screen.dart';
import 'package:wajed_app/core/common_widgets/text_list_empty.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/theming/container_styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/theming/styles.dart';
import '../../data/models/alert_model.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<AlertsCubit>()..getAlerts(userId: currentUser!.user.id, page: 1),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.alerts.tr(),
            style: TextStyles.textStyleFontBold16BlackAppBar,
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
        ),
        body: BlocBuilder<AlertsCubit, AlertsState>(
          builder: (context, state) {
            /// * make swich
            switch (state.getAlertsState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case RequestState.loaded:
                return state.alertsResponse!.items.isEmpty
                    ? TextListEmpty(text: Strings.noAlert.tr())
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 35.w, vertical: 20.h),
                        itemCount: state.alertsResponse!.items.length,
                        itemBuilder: (context, index) {
                          AlertModel alertModel =
                              state.alertsResponse!.items[index];
                          return GestureDetector(
                            onTap: () {
                              onTapAlert(alertModel, context);
                            },
                            child: Container(
                              height: 130.h,
                              margin: EdgeInsets.only(bottom: 25.h),
                              decoration: ContainerStyles.elevationContainner,
                              child: Row(
                                children: [
                                  const ContainerCheckAddress(
                                      color: Palette.restaurantColor),
                                  Padding(
                                    padding: const EdgeInsets.all(12).w,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/alert_item.svg",
                                          width: 40.w,
                                          height: 40.h,
                                        ),
                                        horizontalSpace(10.w),
                                        SizedBox(
                                            width: context.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                /// * title
                                                Text.rich(
                                                  TextSpan(children: [
                                                    TextSpan(
                                                        text: isAraic()
                                                            ? alertModel.titleAr
                                                            : alertModel
                                                                .titleEng),
                                                    TextSpan(text: "  ".tr()),
                                                    TextSpan(
                                                        text:alertModel.type
                                                        ==AppModel.ordersAlert?
                                                         alertModel.pageId.toString():""
                                                            )
                                                  ]),
                                                  style: TextStyles
                                                      .textStyleFontBold16OrangeColor
                                                      .copyWith(height: 1.2),
                                                ),
                                                Text(
                                                  isAraic()
                                                      ? alertModel.descAr
                                                      : alertModel.descEng,
                                                  maxLines: 3,
                                                  style: TextStyles
                                                      .textStyleFontReqluar12kDarkGrey
                                                      .copyWith(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          height: 1.2),
                                                )
                                              ],
                                            )),
                                        Column(
                                          children: [
                                            // date
                                            Text(
                                                context.convertDateDay(
                                                    alertModel.createdAt),
                                                style: TextStyles
                                                    .textStyleFontReqluar12kDarkGrey),
                                            verticalSpace(10.h),

                                            /// * icon
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20.w,
                                              color: Palette.kDarkGrey,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              case RequestState.error:
                return const Text("error");
              default:
                return const Text("error");
            }
          },
        ),
      ),
    );
  }

  void onTapAlert(AlertModel alertModel, BuildContext context) {
    switch (alertModel.type) {
      case AppModel.ordersAlert:
        context.navigatePush(BlocProvider(
          create: (context) => sl<OrderCubit>(),
          child:context.isCleint(AppModel.currentRole)?
           OrderDetailsScreen(orderId: alertModel.pageId):
           OrderDetailsMarketScreen(orderId: alertModel.pageId),
        ));
        break;
      case AppModel.chateAlert:
        context.navigatePush(ConversationsScreen());
        break;
      case AppModel.actionAlert:
        context.navigatePush(AlertDetailsScreen(
          alertModel: alertModel,
        ));
        break;
    }
  }
}
