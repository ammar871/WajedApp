part of 'auth_cubit.dart';

 class AuthState extends Equatable {
  // register
  final RequestState? registerUserState;
  final ResponseRegister? responseRegister;

  // login
  final UserResponse? userResponseModel;
  final RequestState? loginUserState;
  //check 
    final RequestState? checkUserState;

    // delete account 
        final RequestState? deleteAccountState;



    const AuthState(
      {this.registerUserState,
      this.responseRegister,
      this.checkUserState, 
      this.userResponseModel,
      this.deleteAccountState,

      this.loginUserState
      });

       AuthState copyWith(
      {final registerUserState,
      final responseRegister,
     final userResponseModel,
    final  checkUserState,
    // final currentGender,
 final loginUserState,
    final deleteAccountState
      }) {
    return AuthState(
     checkUserState: checkUserState ?? this.checkUserState,
      //   currentCountry: currentCountry ?? this.currentCountry,
        registerUserState: registerUserState ?? this.registerUserState,
        responseRegister: responseRegister ?? this.responseRegister,
        userResponseModel: userResponseModel ?? this.userResponseModel,
      loginUserState: loginUserState ?? this.loginUserState,

      deleteAccountState: deleteAccountState ?? this.deleteAccountState
        );
  }

  @override
  List<Object?> get props => [deleteAccountState,registerUserState, responseRegister,loginUserState,userResponseModel,checkUserState];
}


