import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import 'package:wajed_app/common/address/data/models/address_model.dart';
import 'package:wajed_app/common/address/data/repo/address_repo.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/utils.dart';

import '../../../../core/utils/app_model.dart';
import '../../data/models/add_address_body_request.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final BaseAddress _addressRepo;
  AddressCubit(this._addressRepo) : super(const AddressState());
  static AddressCubit get(context) => BlocProvider.of<AddressCubit>(context);
  Future<void> getAddress({userId}) async {
    emit(AddressState(
        getAddressessStaet: RequestState.loading,
        desfulteAddress:
            currentDefulteAddress != null ? currentDefulteAddress!.id : 0));

    var response = await _addressRepo.getAddress(userId: userId);

    response.when(success: (data) {
      emit(AddressState(
          getAddressessStaet: RequestState.loaded, addresses: data));
    }, failure: (code, message) {
      emit(const AddressState(getAddressessStaet: RequestState.error));
    });
  }

  Future<void> addAddress(AddAddressBodyReqquest addAddressBodyReqquest,
      {context}) async {
    showUpdatesLoading(context);
    emit(const AddressState(addAddressState: RequestState.loading));
    var response = await _addressRepo.addAddress(addAddressBodyReqquest);

    response.when(success: (data) async {
      pop(context);
      pop(context);
      emit(const AddressState(addAddressState: RequestState.loaded));
    }, failure: (code, message) {
      pop(context);
      emit(const AddressState(addAddressState: RequestState.error));
    });
  }

  Future<void> deleteAddress(int addressId) async {
    emit(const AddressState(deleteAddreeeState: RequestState.loading));
    var response = await _addressRepo.deleteAddress(addressId);

    response.when(success: (data) {
      emit(const AddressState(deleteAddreeeState: RequestState.loaded));
    }, failure: (code, message) {
      emit(const AddressState(deleteAddreeeState: RequestState.error));
    });
  }

  Future<void> defulteAddress(int addressId, String userId, {context}) async {
    emit(state.copyWith(
        defulteAddressState: RequestState.loading, desfulteAddress: addressId));
    var response = await _addressRepo.defulteAddress(addressId, userId);

    response.when(success: (data) {
      currentDefulteAddress = data;
      pop(context);
      emit(state.copyWith(defulteAddressState: RequestState.loaded));
    }, failure: (code, message) {
      emit(state.copyWith(defulteAddressState: RequestState.error));
    });
  }

  void changeDefulteAddressState(addressId) {
    emit(state.copyWith(desfulteAddress: addressId));
  }

  Future<void> updateAddress(
      AddAddressBodyReqquest addAddressBodyReqquest, int addressId) async {
    emit(const AddressState(updateAddressState: RequestState.loading));
    var response = await _addressRepo.updateAddress(addAddressBodyReqquest);

    response.when(success: (data) {
      emit(const AddressState(updateAddressState: RequestState.loaded));
    }, failure: (code, message) {
      emit(const AddressState(updateAddressState: RequestState.error));
    });
  }

  String detailsAddress = "";
  Future getAddressFromLatLng(double lat, double long) async {
    emit(state.copyWith(moveCameraState: RequestState.loading));
    List<Placemark> placemarks = await placemarkFromCoordinates(
      lat,
      long,
    );
    // print(placemarks[0]);
    detailsAddress =
        "${placemarks[0].name},${placemarks[0].street},${placemarks[0].administrativeArea},${placemarks[0].subAdministrativeArea} ,${placemarks[0].locality} ,${placemarks[0].subLocality}";

    emit(state.copyWith(moveCameraState: RequestState.loaded));
  }
}
