import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/dio_factory.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/strings.dart';
import '../models/add_complaint_body.dart';
import '../models/complaint_model.dart';

abstract class BaseComplaints{

  Future<ApiResult<ComplaintModel>> addComplaints(AddCopmlaintBody complaintModel);
}

class ComplaintsRepo extends BaseComplaints{
  @override
  Future<ApiResult<ComplaintModel>> addComplaints(AddCopmlaintBody complaintModel) async{
    var data = FormData.fromMap(complaintModel.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.addComplaintPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(ComplaintModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

}