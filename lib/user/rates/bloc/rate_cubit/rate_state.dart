part of 'rate_cubit.dart';

class RateState extends Equatable {
  final RequestState? addRateState;
  final AddRateResponse? rateModel;

  RateState({this.addRateState, this.rateModel});
// *  copy with

  RateState copyWith({
    RequestState? addRateState,
    AddRateResponse? rateModel,
  }) {
    return RateState(
      addRateState: addRateState ?? this.addRateState,
      rateModel: rateModel ?? this.rateModel,
    );
  }
  @override
 
  List<Object?> get props => [
    addRateState,
    rateModel
  ];
}
