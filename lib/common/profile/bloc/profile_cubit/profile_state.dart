part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final RequestState getUserState;
  final UserModel? user;
  final RequestState? editProfileState;
  final RequestState? uploadImageState;
  final String? imageProfile;

  ProfileState(
      {this.getUserState = RequestState.loading,
      this.user,
      this.uploadImageState,
      this.imageProfile,
      this.editProfileState});

// copy with

  ProfileState copyWith(
      {RequestState? getUserState,
      UserModel? user,
      RequestState? editProfileState,
        final RequestState? uploadImageState,
  final String? imageProfile
      }) {
    return ProfileState(
      getUserState: getUserState ?? this.getUserState,
      user: user ?? this.user,
      editProfileState: editProfileState ?? this.editProfileState,
      imageProfile: imageProfile ?? this.imageProfile,
      uploadImageState: uploadImageState ??this.uploadImageState
    );
  }

  @override
  List<Object?> get props => [getUserState, user, editProfileState,
  
  imageProfile,uploadImageState
  ];
}
