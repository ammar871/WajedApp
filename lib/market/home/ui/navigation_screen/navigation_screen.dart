import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/common/app/data/models/menu_model.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/helpers/firebase_manger.dart';
import 'package:wajed_app/core/theming/container_styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/market/home/bloc/cubit/home_market_cubit.dart';
import 'package:wajed_app/market/home/ui/account_screen/account_screen.dart';
import 'package:wajed_app/market/home/ui/home_market_screen/home_market_screen.dart';
import 'package:wajed_app/market/home/ui/messages_screen/messages_screen.dart';
import 'package:wajed_app/market/home/ui/settings_screen/settings_screen.dart';
import 'package:wajed_app/market/home/ui/store_scrreen/store_scrreen.dart';
import 'package:wajed_app/core/common_widgets/darwer_widget/drawer_widget.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/services/services_locator.dart';
import 'components/app_bar_home_widget.dart';
import 'components/create_my_market_widget.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final scaffolded = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const AccountScreen(),
    const StroeScreen(),
    const HomeMarketScreen(),
    const MessagesScreen(),
    const SettingsScreen()
  ];

  @override
  void initState() {
    super.initState();
    getLocation();
    FCMManger().getMessagesFCM();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) =>
          sl<HomeMarketCubit>()..getHomeMarket(currentUser!.user.id),
      child: BlocBuilder<HomeMarketCubit, HomeMarketState>(
        builder: (context, state) {
          switch (state.getHomeMarketState) {
            case RequestState.loading:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case RequestState.loaded:
              return state.homeResponseMarket!.status
                  ?

                  // has market
                  Scaffold(
                      key: scaffolded,
                      drawer: DraweWidget(),
                      bottomNavigationBar: NavigationButtonWidget(),
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(70.0),
                        child: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Palette.restaurantColor,
                          elevation: 0,
                          title: AppBarHomeMarketWidget(
                            title: titlesAppBar[state.currentIndexNav].tr(),
                            onPressed: () {
                              scaffolded.currentState!.openDrawer();
                            },
                          ),
                        ),
                      ),
                      body: RefreshIndicator(
                        onRefresh: () async {
                          HomeMarketCubit.get(context)
                              .getHomeMarket(currentUser!.user.id);
                        },
                        child: IndexedStack(
                          index: state.currentIndexNav,
                          children: _screens,
                        ),
                      ),
                    )
                  : const CreateMyMarketWidget();

            case RequestState.error:
              return Scaffold(
                body: Center(
                  child: Text('حدث خطأ ما'.tr()),
                ),
              );

            case RequestState.pagination:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class NavigationButtonWidget extends StatelessWidget {
// * list items
  final List<NavItemModel> itemsNav = [
    NavItemModel(
        index: 0,
        name: 'home'.tr(),
        icon: 'assets/images/dealer_images/nav_bar/user.svg'),
    NavItemModel(
        index: 1,
        name: 'home'.tr(),
        icon: 'assets/images/dealer_images/nav_bar/store.svg'),
    NavItemModel(
        index: 2,
        name: 'home'.tr(),
        icon: 'assets/images/dealer_images/nav_bar/home.svg'),
    NavItemModel(
        index: 3,
        name: 'home'.tr(),
        icon: 'assets/images/dealer_images/nav_bar/message.svg'),
    NavItemModel(
        index: 4,
        name: 'home'.tr(),
        icon: 'assets/images/dealer_images/nav_bar/settings.svg'),
  ];

  NavigationButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeMarketCubit, HomeMarketState>(
      builder: (context, state) {
        return SizedBox(
          height: 80.0,
          child: Row(
              children: itemsNav
                  .map((e) => Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          HomeMarketCubit.get(context).changeIndexNav(e.index);
                        },
                        child: Container(
                          height: 60.w,
                          width: 60.w,
                          margin: EdgeInsets.only(bottom: 20.h),
                          decoration: state.currentIndexNav == e.index
                              ? ContainerStyles.decorationButtonNav()
                              : const BoxDecoration(),
                          child: Center(
                            child: SvgPicture.asset(
                              e.icon,
                              colorFilter: ColorFilter.mode(
                                  state.currentIndexNav == e.index
                                      ? Palette.white
                                      : Palette.kGreyColor,
                                  BlendMode.srcIn),
                            ),
                          ),
                        ),
                      )))
                  .toList()),
        );
      },
    );
  }
}
