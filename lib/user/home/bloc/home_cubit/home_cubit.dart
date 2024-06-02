import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/user/home/data/repo/home_repo.dart';

import '../../../../common/app/data/repo/app_repo.dart';
import '../../../../common/auth/data/models/user_response.dart';
import '../../../../core/enums/loading_status.dart';
import '../../data/models/home_user_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BaseHomeUser _homeUserRepo;
  final BaseApp _appRepo;
  HomeCubit(this._homeUserRepo, this._appRepo) : super(const HomeState());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  /// get home user
  Future getHomeUser({context, userId}) async {
    emit(const HomeState(getHomeState: RequestState.loading));
    final response = await _homeUserRepo.getHomeUser(userId);
    response.when(success: (homeResponse) async {
      fields = homeResponse.fields;
      if (homeResponse.userDetail != null) {
        currentUser = UserResponse(
            token: currentUser!.token, user: homeResponse.userDetail!);
        print(currentUser!.user.profileImage.toString() + "=========>");
        favFound.clear();
        for (var element in homeResponse.favorites) {
          favFound.add(element.marketId);
        }
        await _appRepo.updateDeviceToken(
            userId: currentUser!.user.id, token: AppModel.deviceToken);
      }
      if (homeResponse.hasDefaultAddress) {
        currentDefulteAddress = homeResponse.defaultAddress;
      }
      emit(HomeState(
          homeUserResponse: homeResponse, getHomeState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code ====================> getHome Status");
      emit(const HomeState(getHomeState: RequestState.loaded));
    });
  }
}
