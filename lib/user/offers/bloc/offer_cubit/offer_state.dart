part of 'offer_cubit.dart';

class OfferState extends Equatable {
  final RequestState getOffersState;
  final List<OfferModel> offers;
  final RequestState getMarketsByOfferIdState;
  final MarketResponse? marketsByOfferId;

  OfferState(
      {this.getOffersState = RequestState.loading,
      this.offers = const [],
      this.getMarketsByOfferIdState = RequestState.loading,
      this.marketsByOfferId});

  // copy with
  OfferState copyWith(
          {RequestState? getOffersState,
          List<OfferModel>? offers,
          RequestState? getMarketsByOfferIdState,
          MarketResponse? marketsByOfferId}) =>
      OfferState(
          getOffersState: getOffersState ?? this.getOffersState,
          offers: offers ?? this.offers,
          getMarketsByOfferIdState:
              getMarketsByOfferIdState ?? this.getMarketsByOfferIdState,
          marketsByOfferId: marketsByOfferId ?? this.marketsByOfferId);

          
  @override
  List<Object?> get props =>
      [getOffersState, offers, getMarketsByOfferIdState, marketsByOfferId];
}
