part of 'address_cubit.dart';

class AddressState extends Equatable {
  final RequestState getAddressessStaet;
  final List<AddressModel> addresses;
  final RequestState? addAddressState;
  final RequestState? updateAddressState;
  final RequestState? deleteAddreeeState;
  final RequestState? defulteAddressState;
  final RequestState? moveCameraState;

  final int? desfulteAddress;

  ///constractor
  const AddressState(
      {this.getAddressessStaet = RequestState.loading,
      this.addresses = const [],
      this.addAddressState, this.desfulteAddress,
      this.updateAddressState,
      this.deleteAddreeeState,
      this.defulteAddressState,
      this.moveCameraState});

  // copy with

  AddressState copyWith(
      {RequestState? getAddressessStaet,
      List<AddressModel>? addresses,
      RequestState? addAddressState,
      RequestState? updateAddressState,
      RequestState? deleteAddreeeState,
      RequestState? defulteAddressState,
      RequestState? moveCameraState,
      int? desfulteAddress
      
      
      }) {
    return AddressState(
        getAddressessStaet: getAddressessStaet ?? this.getAddressessStaet,
        addresses: addresses ?? this.addresses,
        addAddressState: addAddressState ?? this.addAddressState,
        updateAddressState: updateAddressState ?? this.updateAddressState,
        deleteAddreeeState: deleteAddreeeState ?? this.deleteAddreeeState,
        defulteAddressState: defulteAddressState ?? this.defulteAddressState,
        moveCameraState: moveCameraState ?? this.moveCameraState,
        desfulteAddress: desfulteAddress ?? this.desfulteAddress
        );
  }

  @override

  List<Object?> get props => [
        getAddressessStaet,
        addresses,
        addAddressState,
        updateAddressState,
        deleteAddreeeState,
        defulteAddressState,
        moveCameraState,
        desfulteAddress
      ];
}
