import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/user/favoraite/data/models/add_fav_body.dart';
import 'package:wajed_app/user/favoraite/data/models/favoraite_response.dart';
import 'package:wajed_app/user/favoraite/data/repo/favoraite_repo.dart';
import '../../../../core/utils/app_model.dart';
part 'favoraite_state.dart';

class FavoraiteCubit extends Cubit<FavoraiteState> {
  final BaseFavoraite _favRepo;
  FavoraiteCubit(this._favRepo) : super(FavoraiteState());
 static FavoraiteCubit get(context) => BlocProvider.of<FavoraiteCubit>(context);
 
  // get favoraites
  Future<void> getFavoraites({userId}) async {
    emit(state.copyWith(getFavoraitsState: RequestState.loading));
    var result = await _favRepo.getFavoraites(userId: userId);
    result.when(success: (data) {
      favFound.clear();
      for (var element in data) {
        favFound.add(element.favorite.marketId);
      }
      emit(state.copyWith(
          getFavoraitsState: RequestState.loaded, favoraites: data));
    }, failure: (code, message) {
      emit(state.copyWith(getFavoraitsState: RequestState.error));
    });
  }

  // add favoraites
  Future<void> addFavoraites(AddFavBody addFavBody) async {
    favFound.contains(addFavBody.marketId)
        ? favFound.remove(addFavBody.marketId)
        : favFound.add(addFavBody.marketId);
    emit(state.copyWith(addFavState: RequestState.loading));
    var result = await _favRepo.addFavoraite(addFavBody);
    result.when(success: (data)async {
      emit(state.copyWith(addFavState: RequestState.loaded));
    await  getFavoraites(userId: addFavBody.userId);
    }, failure: (code, message) {
      emit(state.copyWith(addFavState: RequestState.error));
    });
  }
}
