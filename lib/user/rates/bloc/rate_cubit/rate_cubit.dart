import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/user/rates/data/models/add_rate_body_model.dart';
import 'package:wajed_app/user/rates/data/models/rate_model.dart';
import 'package:wajed_app/user/rates/data/repo/rate_repo.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  final BaseRate _rateRepo;
  RateCubit(this._rateRepo) : super(RateState());
  static RateCubit get(context) => BlocProvider.of<RateCubit>(context);

  Future addRate(AddRateBodyModel rateBody) async {
    emit(state.copyWith(addRateState: RequestState.loading));
    final result = await _rateRepo.addRate(rateBody);
    result.when(
      success: (data) {
        showToast(msg: data.message);
        emit(
            state.copyWith(addRateState: RequestState.loaded, rateModel: data));
      },
      failure: (code, error) {
        emit(state.copyWith(addRateState: RequestState.error));
      },
    );
  }
}
