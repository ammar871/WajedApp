import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/common/app/data/repo/app_repo.dart';

import 'package:wajed_app/common/auth/data/models/user_response.dart';
import 'package:wajed_app/common/profile/data/repo/profile_repo.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/user/home/ui/home_screen/home_screen.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../data/models/update_peofile_body.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final BaseProfile _profileRepo;
  final BaseApp _baseRepo;
  ProfileCubit(this._profileRepo, this._baseRepo) : super(ProfileState());

  static ProfileCubit get(context) => BlocProvider.of<ProfileCubit>(context);

// * get user data
  Future<void> getProfileDetails() async {
    emit(state.copyWith(getUserState: RequestState.loading));
    final result = await _profileRepo.getUserProfile();
    result.when(
      success: (data) {
        emit(state.copyWith(getUserState: RequestState.loaded, user: data,imageProfile: data.profileImage));
      },
      failure: (code, message) {
        emit(state.copyWith(getUserState: RequestState.error));
      },
    );
  }

  /// * edit profile
  Future<void> editProfile(
      UpdateProfileBody updateProfileBody, BuildContext context) async {
    emit(state.copyWith(editProfileState: RequestState.loading));
    final result = await _profileRepo.editProfile(updateProfileBody);
    result.when(
      success: (data) async{
       context.navigatePush(HomeScreen());
        await getProfileDetails();
        showToast(msg: Strings.successSaved.tr(), color: Colors.green);
        currentUser=UserResponse(token: currentUser!.token, user: data);
        emit(state.copyWith(editProfileState: RequestState.loaded, user: data));
      },
      failure: (code, message) {
        emit(state.copyWith(editProfileState: RequestState.error));
      },
    );
  }

  /// * upload image profile
  Future<void> uploadImageProfile() async {
    final file = await _baseRepo.getImagePicker();
    file.when(
        success: (data) async {
          emit(state.copyWith(uploadImageState: RequestState.loading));
          final result = await _baseRepo.uploadIamage(data);
          result.when(
            success: (data) {
              print(data);
              emit(state.copyWith(
                  uploadImageState: RequestState.loaded, imageProfile: data));
            },
            failure: (code, message) {
              emit(state.copyWith(uploadImageState: RequestState.error));
            },
          );
        },
        failure: (c, m) {
           showToast(msg: Strings.successSaved.tr(), color: Colors.green);
            emit(state.copyWith(uploadImageState: RequestState.error));
        });
  }


  getImageForeUpdateProfile({image}){
    print("object");
    emit(state.copyWith(imageProfile: image));
  }
}
