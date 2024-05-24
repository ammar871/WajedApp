import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/common/app/data/repo/app_repo.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/market/home/data/models/home_market_response.dart';
import 'package:wajed_app/market/home/data/repo/home_market_repo.dart';
part 'home_market_state.dart';

class HomeMarketCubit extends Cubit<HomeMarketState> {
  final BaseHomeMarket _homeMarketRepo;
  final BaseApp _baseApp;
 
  HomeMarketCubit(this._homeMarketRepo, this._baseApp)
      : super(const HomeMarketState());
  static HomeMarketCubit get(context) =>
      BlocProvider.of<HomeMarketCubit>(context);

  /// * get home
  List<OrderRsponseMarket> ordrers = [];
  Future<void> getHomeMarket(String userId) async {
    emit(state.copyWith(getHomeMarketState: RequestState.loading));
    var result = await _homeMarketRepo.getHomeMarket(userId);
    result.when(
      success: (response) async {
        if (response.status) {
          categories = response.data!.categories;
          ordrers = response.data!.lastOrders;
          marketDetails = response.data!.market;
          await _baseApp.updateDeviceToken(
              userId: currentUser!.user.id, token:  AppModel.deviceToken);
        }

        emit(state.copyWith(
            getHomeMarketState: RequestState.loaded,
            homeResponseMarket: response));
      },
      failure: (code, message) {
        emit(state.copyWith(getHomeMarketState: RequestState.error));
      },
    );
  }


// * change current index nave
  changeIndexNav(int index) {
    emit(state.copyWith(currentIndexNav: index));
  }
}
