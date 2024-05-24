part of 'home_market_cubit.dart';

class HomeMarketState extends Equatable {
  final RequestState getHomeMarketState;
  final HomeResponseMarket? homeResponseMarket;
  final int currentIndexNav;
  

  const HomeMarketState({
    this.getHomeMarketState = RequestState.loading,
    this.homeResponseMarket,this.currentIndexNav=2
  });

  // * copy with

  HomeMarketState copyWith({
    RequestState? getHomeMarketState,
    HomeResponseMarket? homeResponseMarket,
    int? currentIndexNav
  }) {
    return HomeMarketState(
      getHomeMarketState: getHomeMarketState ?? this.getHomeMarketState,
      homeResponseMarket: homeResponseMarket ?? this.homeResponseMarket,
      currentIndexNav: currentIndexNav ?? this.currentIndexNav
    );
  }

  @override
  List<Object?> get props => [getHomeMarketState, homeResponseMarket, currentIndexNav];
}
