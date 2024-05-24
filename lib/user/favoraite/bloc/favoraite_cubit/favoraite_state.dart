part of 'favoraite_cubit.dart';

class FavoraiteState extends Equatable {
  final RequestState? addFavState;
  final List<FavoraiteResponse> favoraites;
  final RequestState? getFavoraitsState;

  FavoraiteState(
      {this.addFavState, this.favoraites = const [], this.getFavoraitsState});
  // copy with

  FavoraiteState copyWith(
      {RequestState? addFavState,
      List<FavoraiteResponse>? favoraites,
      RequestState? getFavoraitsState}) {
    return FavoraiteState(
        addFavState: addFavState ?? this.addFavState,
        favoraites: favoraites ?? this.favoraites,
        getFavoraitsState: getFavoraitsState ?? this.getFavoraitsState);
  }

  @override
  List<Object?> get props => [addFavState, favoraites, getFavoraitsState];
}
