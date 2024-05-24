import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/common/alerts/data/models/alert_respone.dart';
import 'package:wajed_app/common/alerts/data/repo/alerts_repo.dart';
import 'package:wajed_app/core/enums/loading_status.dart';

part 'alerts_state.dart';

class AlertsCubit extends Cubit<AlertsState> {
  final BaseAlert _alertRepo;
  AlertsCubit(this._alertRepo) : super(const AlertsState());
  static AlertsCubit get(context) => BlocProvider.of<AlertsCubit>(context);

  // * get alerts
  Future<void> getAlerts({userId, page}) async {
    emit(state.copyWith(getAlertsState: RequestState.loading));
    final response = await _alertRepo.getAlerts(userId: userId, page: page);
    response.when(
      success: (data) {
        emit(state.copyWith(
            getAlertsState: RequestState.loaded, alertsResponse: data));
      },
      failure: (statusCode, message) {
        emit(state.copyWith(getAlertsState: RequestState.error));
      },
    );
  }
}
