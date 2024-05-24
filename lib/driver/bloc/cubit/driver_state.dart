part of 'driver_cubit.dart';

class DriverState extends Equatable {
  final RequestState getHomeDriverState;
  final HomeDriverResponse? homeDriverResponse;
  final RequestState? addDriverState;
  final RequestState? uploadImageProfileState;
    final RequestState? uploadImageIdState;
      final RequestState? uploadImageCarState;
      final String? imageProfile, imageId, imageCar;

  const DriverState({
    this.getHomeDriverState = RequestState.loading,
    this.homeDriverResponse,
    this.addDriverState ,
    this.uploadImageProfileState,
    this.uploadImageIdState,
    this.uploadImageCarState,
    this.imageProfile,
    this.imageId,
    this.imageCar
  });

  DriverState copyWith({
    RequestState? getHomeDriverState,
    HomeDriverResponse? homeDriverResponse,
    RequestState? addDriverState,
    RequestState? uploadImageState,
    RequestState? uploadImageProfileState,
    RequestState? uploadImageIdState,
    RequestState? uploadImageCarState,
    String? imageProfile,
    String? imageId,
    String? imageCar
  }) {
    return DriverState(
      getHomeDriverState: getHomeDriverState ?? this.getHomeDriverState,
      homeDriverResponse: homeDriverResponse ?? this.homeDriverResponse,
      addDriverState: addDriverState ?? this.addDriverState,
   
      uploadImageProfileState: uploadImageProfileState ?? this.uploadImageProfileState,
      uploadImageIdState: uploadImageIdState ?? this.uploadImageIdState,
      uploadImageCarState: uploadImageCarState ?? this.uploadImageCarState,
      imageProfile: imageProfile ?? this.imageProfile,
      imageId: imageId ?? this.imageId,
      imageCar: imageCar ?? this.imageCar
    );
  }
  
  @override

  List<Object?> get props => [
    getHomeDriverState,
    homeDriverResponse,
    addDriverState,
 
    uploadImageProfileState,
    uploadImageIdState,
    uploadImageCarState,
    imageProfile,
    imageId,
    imageCar
  ];
}
