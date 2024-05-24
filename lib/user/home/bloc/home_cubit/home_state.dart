part of 'home_cubit.dart';






class HomeState extends Equatable {
  final RequestState getHomeState;
  final HomeUserResponse? homeUserResponse;

  const HomeState({ this.getHomeState =RequestState.loading,  this.homeUserResponse});

  @override

  List<Object?> get props => [getHomeState,homeUserResponse];

}
