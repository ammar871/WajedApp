import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/common/complaints/data/repo/complaints_repo.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import '../../../../core/utils/strings.dart';
import '../../data/models/add_complaint_body.dart';
part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  final BaseComplaints _complaintsRepo;
  ComplaintCubit(this._complaintsRepo) : super(const ComplaintState());
  static ComplaintCubit get(context) =>
      BlocProvider.of<ComplaintCubit>(context);

  /// * add complaint
  Future<void> addComplainnt(AddCopmlaintBody complaintModel,{context}) async {
    emit(const ComplaintState(
      addComplaintState: RequestState.loading,
    ));

    var response = await _complaintsRepo.addComplaints(complaintModel);

    response.when(success: (data) {
      showToast(color: Colors.green, msg: Strings.sendMessage.tr());
      emit(const ComplaintState(
        addComplaintState: RequestState.loaded,
      ));
    }, failure: (code, message) {
      emit(const ComplaintState(
        addComplaintState: RequestState.error,
      ));
    });
  }
}
