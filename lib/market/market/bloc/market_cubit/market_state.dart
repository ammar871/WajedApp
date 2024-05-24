part of 'market_cubit.dart';

class MarketState extends Equatable {
  // * market details
  final RequestState getMarketDetailsState;
  final MarketDetailsResponse? marketDetailsResponse;

  // * markets by field id
  final RequestState getMarketsByFieldIdState;
  final MarketResponse? marketResponse;

  // * search market
  final RequestState? searchMarketState;
  final List<MarketModel> markets;
  final int currentIndex;

  // * add market
  final RequestState? getFieldsForAddMarketState;
  final List<FieldModel> fields;
  final RequestState? addMarketState;

  final RequestState? uploadLogoMarketState;
  final RequestState? uploadimageIdMarketState;
  final String? imageLogoMarket, imageIdMarket;

  const MarketState(
      {
      // * market details
      this.getMarketDetailsState = RequestState.loading,
      this.currentIndex = 0,
      this.marketDetailsResponse,

      // * markets by field id
      this.getMarketsByFieldIdState = RequestState.loading,
      this.marketResponse,

      // * search market
      this.searchMarketState,
      this.markets = const [],

      // * add market
      this.addMarketState,
      this.getFieldsForAddMarketState,
      this.uploadLogoMarketState,
      this.uploadimageIdMarketState,
      this.imageLogoMarket,
      this.imageIdMarket,
      this.fields = const []});

  MarketState copyWith({
    RequestState? getMarketDetailsState,
    final int? currentIndex,
    MarketDetailsResponse? marketDetailsResponse,

    // * markets by field id
    RequestState? getMarketDetailsByFieldIdState,
    MarketResponse? marketResponse,

    // * search market
    final RequestState? searchMarketState,
    final List<MarketModel>? markets,

    // * add market
    RequestState? getFieldsForAddMarketState,
    List<FieldModel>? fields,
    final RequestState? addMarketState,
    final RequestState? uploadLogoMarketState,
    final RequestState? uploadimageIdMarketState,
    final String? imageLogoMarket,
    final String? imageIdMarket,
  }) =>
      MarketState(
        getMarketDetailsState:
            getMarketDetailsState ?? this.getMarketDetailsState,
        currentIndex: currentIndex ?? this.currentIndex,
        marketDetailsResponse:
            marketDetailsResponse ?? this.marketDetailsResponse,

        // * markets by field id
        getMarketsByFieldIdState:
            getMarketDetailsState ?? this.getMarketDetailsState,
        marketResponse: marketResponse ?? this.marketResponse,
        // * search Market
        searchMarketState: searchMarketState ?? this.searchMarketState,
        markets: markets ?? this.markets

       // * add market
        ,
        getFieldsForAddMarketState:
            getFieldsForAddMarketState ?? this.getFieldsForAddMarketState,
        fields: fields ?? this.fields,
        addMarketState: addMarketState ?? this.addMarketState,

        uploadLogoMarketState:
            uploadLogoMarketState ?? this.uploadLogoMarketState,
        uploadimageIdMarketState:
            uploadimageIdMarketState ?? this.uploadimageIdMarketState,
        imageLogoMarket: imageLogoMarket ?? this.imageLogoMarket,
        imageIdMarket: imageIdMarket ?? this.imageIdMarket,
      );

  @override
  List<Object?> get props => [
        getMarketDetailsState, marketDetailsResponse, currentIndex,

        // * markets by field id
        getMarketsByFieldIdState, marketResponse,
        markets, searchMarketState, getFieldsForAddMarketState, fields,
        addMarketState,

        uploadLogoMarketState, uploadimageIdMarketState, imageLogoMarket,
        imageIdMarket
      ];
}
