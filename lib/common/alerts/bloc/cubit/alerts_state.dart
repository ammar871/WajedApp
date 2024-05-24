part of 'alerts_cubit.dart';


class AlertsState extends Equatable {
  final RequestState getAlertsState;
  final AlertResponse? alertsResponse;

  const AlertsState({ this.getAlertsState= RequestState.loading,  this.alertsResponse});

  AlertsState copyWith({
    RequestState? getAlertsState,
    AlertResponse? alertsResponse,
  }) {
    return AlertsState(
      getAlertsState: getAlertsState ?? this.getAlertsState,
      alertsResponse: alertsResponse ?? this.alertsResponse,
    );
  }
  
  @override
 
  List<Object?> get props =>[getAlertsState,alertsResponse];


}
