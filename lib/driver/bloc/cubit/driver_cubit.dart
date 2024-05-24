import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/driver/data/models/home_response_driver.dart';
import 'package:wajed_app/driver/data/repo/driver_repo.dart';
import 'package:wajed_app/driver/ui/create_account_driver_screen/success_create_account.dart';
import '../../../common/app/data/repo/app_repo.dart';
import '../../data/models/add_driver_body.dart';
import '../../ui/create_account_driver_screen/create_account_driver_screen.dart';

part 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  final BaseDriver _driverRepo;
  final BaseApp _appRepo;
  DriverCubit(this._driverRepo, this._appRepo) : super(const DriverState());
  static DriverCubit get(context) => BlocProvider.of<DriverCubit>(context);

  /// * add driver
  Future<void> addDriver(AddDriverBody addDriverBody, {context}) async {
    emit(state.copyWith(addDriverState: RequestState.loading));
    final result = await _driverRepo.addDriver(addDriverBody);
    result.when(
      success: (data) {
        pushPage(context, const SuccessCreateAccountScreen());
        emit(state.copyWith(addDriverState: RequestState.loaded));
      },
      failure: (code, message) {
        emit(state.copyWith(addDriverState: RequestState.error));
      },
    );
  }

  /// * get home driver
  Future<void> getHomeDriver(String userId, {context}) async {
    emit(state.copyWith(getHomeDriverState: RequestState.loading));
    final result = await _driverRepo.getHomeDriver(userId);
    result.when(
      success: (data) async {
        if (!data.status) {
          pushPage(context, const CreateDriverAccountScreen());
        } else {
          driverDetails = data.data!.driver;
          await _appRepo.updateDeviceToken(
              userId: currentUser!.user.id, token: AppModel.deviceToken);
        }
        emit(state.copyWith(
            getHomeDriverState: RequestState.loaded, homeDriverResponse: data));
      },
      failure: (code, message) {
        emit(state.copyWith(getHomeDriverState: RequestState.error));
      },
    );
  }

  /// * update Status
  // *upload image
  Future uploadImage({typeImage}) async {
    // * profile
    if (typeImage == 1) {
      emit(state.copyWith(uploadImageProfileState: RequestState.loading));
    }
    // * id image
    else if (typeImage == 2) {
      emit(state.copyWith(uploadImageIdState: RequestState.loading));
    }
    // * car image
    else {
      emit(state.copyWith(uploadImageCarState: RequestState.loading));
    }

    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      final response = await _appRepo.uploadIamage(image);
      response.when(success: (image) {
        // * profile
        if (typeImage == 1) {
          emit(state.copyWith(
              uploadImageProfileState: RequestState.loaded,
              imageProfile: image));
        }
        // * id image
        else if (typeImage == 2) {
          emit(state.copyWith(
              uploadImageIdState: RequestState.loaded, imageId: image));
        }
        // * car image
        else {
          emit(state.copyWith(
              uploadImageCarState: RequestState.loaded, imageCar: image));
        }
      }, failure: (code, message) {
        debugPrint("$code===================> getMarketDetails Status code");
        // * profile
        if (typeImage == 1) {
          emit(state.copyWith(uploadImageProfileState: RequestState.error));
        }
        // * id image
        else if (typeImage == 2) {
          emit(state.copyWith(uploadImageIdState: RequestState.error));
        }
        // * car image
        else {
          emit(state.copyWith(uploadImageCarState: RequestState.error));
        }
      });
    }
  }
}
