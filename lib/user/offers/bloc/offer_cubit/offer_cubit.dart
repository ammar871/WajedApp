import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wajed_app/user/offers/data/models/offfer_model.dart';
import 'package:wajed_app/user/offers/data/repo/offfer_repo.dart';

import '../../../../core/enums/loading_status.dart';
import '../../../../market/market/data/models/market_response.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  final BaseOffer _baseOffer;
  OfferCubit(this._baseOffer) : super(OfferState());
 static OfferCubit get(context) => BlocProvider.of<OfferCubit>(context);
  // *  get offers
  Future<void> getOffers({userId, page}) async {
    emit(state.copyWith(getOffersState: RequestState.loading));
    final result = await _baseOffer.getOffers(userId: userId, page: page);
    result.when(
      success: (offers) {
        emit(state.copyWith(getOffersState: RequestState.loaded, offers: offers));
      },
      failure: (code,message) {
        emit(state.copyWith(getOffersState: RequestState.error, offers: []));
      },
    );
  }

  // * get markets by offer id
  Future<void> getMarketsByOfferId(
      {required int offerId, required int addressId, required int page}) async {
    emit(state.copyWith(getMarketsByOfferIdState: RequestState.loading));
    final result = await _baseOffer
        .getMarketsByOfferId(offerId: offerId, addressId: addressId, page: page);
    result.when(
      success: (markets) {
        emit(state.copyWith(
            getMarketsByOfferIdState: RequestState.loaded,
            marketsByOfferId: markets));
      },
      failure: (code,message) {
        emit(state.copyWith(
            getMarketsByOfferIdState: RequestState.error,
           ));
      },
    );
  }
}
