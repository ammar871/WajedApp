import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wajed_app/common/address/data/models/add_address_body_request.dart';
import 'package:wajed_app/common/address/data/models/address_model.dart';
import 'package:wajed_app/core/network/api_result.dart';
import 'package:wajed_app/core/network/dio_factory.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../core/utils/api_constatns.dart';

abstract class BaseAddress {
  Future<ApiResult<List<AddressModel>>> getAddress({userId});

  Future<ApiResult<AddressModel>> addAddress(
      AddAddressBodyReqquest addAddressBodyReqquest);

  Future<ApiResult<AddressModel>> updateAddress(
      AddAddressBodyReqquest addAddressBodyReqquest);

  Future<ApiResult<AddressModel>> deleteAddress(int addressId);

  Future<ApiResult<AddressModel>> defulteAddress(int addressId, String userId);
}

class AddressRepo implements BaseAddress {
  @override
  Future<ApiResult<AddressModel>> addAddress(
      AddAddressBodyReqquest addAddressBodyReqquest) async {
    var data = FormData.fromMap(addAddressBodyReqquest.toJson());

    var response = await DioFactory.dio!.request(
      ApiConstants.addAddressPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(AddressModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<AddressModel>> updateAddress(
      AddAddressBodyReqquest addAddressBodyReqquest) async{
   var data = FormData.fromMap(addAddressBodyReqquest.toJson(),);

    var response = await DioFactory.dio!.request(
      ApiConstants.updateAddressPath,
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(AddressModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message: Strings.someError.tr());
    }
  }
  @override
  Future<ApiResult<AddressModel>> defulteAddress(
      int addressId, String userId)  async{
    var data =
        FormData.fromMap({"addressId": addressId.toString(), "userId": userId});

    var response = await DioFactory.dio!.request(
      ApiConstants.defulteAddressPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(AddressModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message:  Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<AddressModel>> deleteAddress(int addressId) async{

       var data =
        FormData.fromMap({"addressId": addressId.toString()});

    var response = await DioFactory.dio!.request(
      ApiConstants.deleteAddressPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return ApiResult.success(AddressModel.fromJson(response.data));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message:  Strings.someError.tr());
    }
  }

  @override
  Future<ApiResult<List<AddressModel>>> getAddress({userId}) async {
    var response = await DioFactory.dio!.request(
      '${ApiConstants.getAddressesPath}userId=$userId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return ApiResult.success(List.from(
          (response.data as List).map((e) => AddressModel.fromJson(e))));
    } else {
      return ApiResult.failure(
          statusCode: response.statusCode.toString(),
          message:  Strings.someError.tr());
    }
  }


}
