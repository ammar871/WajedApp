import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wajed_app/common/app/data/repo/app_repo.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/market/home/ui/navigation_screen/navigation_screen.dart';
import 'package:wajed_app/market/market/data/models/add_market_body_request.dart';
import 'package:wajed_app/market/market/data/models/update_market_model.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../user/home/data/models/field_model.dart';
import '../../data/models/filter_body_request.dart';
import '../../data/models/mareket_details_response.dart';
import '../../data/models/market_model.dart';
import '../../data/models/market_response.dart';
import '../../data/repo/market_repo.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  final BaseMarket _marketRepo;
  final BaseApp _appRepo;
  MarketCubit(this._marketRepo, this._appRepo) : super(const MarketState());
  static MarketCubit get(context) => BlocProvider.of<MarketCubit>(context);

  /// * get market details
  emitGetMarketDetails({context, marketId}) async {
    emit(const MarketState(getMarketDetailsState: RequestState.loading));
    final response = await _marketRepo.getMarketDetails(marketId);
    response.when(success: (marketDetailsResponse) {
      emit(MarketState(
          marketDetailsResponse: marketDetailsResponse,
          getMarketDetailsState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> getMarketDetails Status code");
      emit(const MarketState(getMarketDetailsState: RequestState.error));
    });
  }

//* markets by field id
  emitGetMarketsByFieldId({context, fieldId, addressId, page}) async {
    emit(const MarketState(getMarketsByFieldIdState: RequestState.loading));
    final response = await _marketRepo.getMarketsByFieldId(
        fieldId: fieldId, addressId: addressId, page: page);
    response.when(success: (marketResponse) {
      emit(MarketState(
          marketResponse: marketResponse,
          getMarketsByFieldIdState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint(
          "$code===================> emitGetMarketsByFieldId Status code");
      emit(const MarketState(getMarketsByFieldIdState: RequestState.error));
    });
  }


  /// * filters markets
  emitFiltersMarkets(FilterBodyRequest filterBodyRequest,{context}) async {
    emit(const MarketState(getMarketsByFieldIdState: RequestState.loading));
    final response = await _marketRepo.filtersMarkets(filterBodyRequest);
    response.when(success: (marketResponse) {
      emit(MarketState(
          marketResponse: marketResponse,
          getMarketsByFieldIdState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> filtersMarkets Status code");
      emit(const MarketState(getMarketsByFieldIdState: RequestState.error));
    });
  }
  

// * search markets

  emitSearchMarkets({context, textSearch, addressId, page}) async {
    emit(const MarketState(searchMarketState: RequestState.loading));
    final response = await _marketRepo.searchMarkets(
        textSearch: textSearch, addressId: addressId);
    response.when(success: (marketResponse) {
      emit(MarketState(
          markets: marketResponse, searchMarketState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> emitSearchMarkets Status code");
      emit(const MarketState(searchMarketState: RequestState.error));
    });
  }

// * . add market

  emitAddMarket(AddMarketBodyRequest addMarketBodyRequest, {context}) async {
    emit(const MarketState(addMarketState: RequestState.loading));
    final response = await _marketRepo.addMarket(addMarketBodyRequest);
    response.when(success: (marketResponse) {
      pushPage(context, const NavigationScreen());
      emit(const MarketState(addMarketState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> emitAddMarket Status code");
      emit(const MarketState(addMarketState: RequestState.error));
    });
  }

// * update market

  emitUpdateMarket(UpdateMarketModel marketModel, {context}) async {
    emit(const MarketState(addMarketState: RequestState.loading));
    final response = await _marketRepo.updateMarket(marketModel);
    response.when(success: (marketResponse) {
      pushPage(context, const NavigationScreen());
      emit(const MarketState(addMarketState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> emitUpdateMarket Status code");
      emit(const MarketState(addMarketState: RequestState.error));
    });
  }

  /// * get fields for market

  Future<void> getFieldsForAddMarket() async {
    emit(state.copyWith(getFieldsForAddMarketState: RequestState.loading));
    var result = await _marketRepo.getFields();
    result.when(
      success: (response) {
        fields = response;
        emit(state.copyWith(
            getFieldsForAddMarketState: RequestState.loaded, fields: response));
      },
      failure: (code, message) {
        emit(state.copyWith(getFieldsForAddMarketState: RequestState.error));
      },
    );
  }

// *upload image
  Future uploadImage({typeImage}) async {
    // * logo
    if (typeImage == 1) {
      emit(state.copyWith(uploadLogoMarketState: RequestState.loading));
    }
    // * id image
    else {
      emit(state.copyWith(uploadimageIdMarketState: RequestState.loading));
    }

    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      final response = await _appRepo.uploadIamage(image);
      response.when(success: (image) {
        // * logo
        if (typeImage == 1) {
          emit(state.copyWith(
              uploadLogoMarketState: RequestState.loaded,
              imageLogoMarket: image));
        }
        // * id image
        else {
          emit(state.copyWith(
              uploadimageIdMarketState: RequestState.loaded,
              imageIdMarket: image));
        }
      }, failure: (code, message) {
        debugPrint("$code===================> getMarketDetails Status code");
        // * logo
        if (typeImage == 1) {
          emit(state.copyWith(
            uploadLogoMarketState: RequestState.error,
          ));
        }
        // * id image
        else {
          emit(state.copyWith(
            uploadimageIdMarketState: RequestState.error,
          ));
        }
      });
    }
  }

// * change current index tab bar category of Market
  changeCurrentIndexCategory(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void getImagesForUpdateMarket(
      {required String imageLogo, required String imagePass}) {
    debugPrint(imagePass);
    emit(state.copyWith(imageIdMarket: imagePass, imageLogoMarket: imageLogo));
  }
}
