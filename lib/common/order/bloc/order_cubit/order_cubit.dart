import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wajed_app/common/order/data/models/order_details_response.dart';
import 'package:wajed_app/common/order/data/models/order_model.dart';
import 'package:wajed_app/common/order/data/models/order_response.dart';
import 'package:wajed_app/common/order/data/repo/order_repo.dart';
import 'package:wajed_app/common/order/ui/success_order_screen/success_order_screen.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/utils.dart';
import 'package:wajed_app/driver/bloc/cubit/driver_cubit.dart';
import '../../../../core/utils/strings.dart';
import '../../data/models/add_order_body.dart';
import '../../data/models/orders_market_response.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  /// * dependencies
  final BaseOrder _orderRepo;

  /// * init cubit
  OrderCubit(this._orderRepo) : super(const OrderState());

  static OrderCubit get(context) => BlocProvider.of<OrderCubit>(context);
  //* get orders
  Future<void> getOrders(int page,int status) async {
    emit(state.copyWith(getOrdersState: RequestState.loading));
    var response = await _orderRepo.getOrders(currentUser!.user.id,page,status);

    response.when(success: (data) {
      emit(state.copyWith(
          getOrdersState: RequestState.loaded, orderResponse: data));
    }, failure: (statusCode, message) {
      emit(state.copyWith(getOrdersState: RequestState.error));
    });
  }

  // * get orders market
  List<OrderModel> orders = [];
  Future<void> getOrdersMarket({marketId, page}) async {
    emit(state.copyWith(getOrdersMarketState: RequestState.loading));
    var response =
        await _orderRepo.getOrdersByMarketId(marketId: marketId, page: page);

    response.when(success: (data) {
      orders = data.items;
      emit(state.copyWith(
          getOrdersMarketState: RequestState.loaded, ordersMarket: data));
    }, failure: (statusCode, message) {
      emit(state.copyWith(getOrdersMarketState: RequestState.error));
    });
  }

  // * get order details
  Future<void> getOrderDetails(int orderId) async {
    emit(state.copyWith(getOrderDetailsState: RequestState.loading));
    var response = await _orderRepo.getOrderDetails(orderId);

    response.when(success: (data) {
      emit(state.copyWith(
          getOrderDetailsState: RequestState.loaded,
          orderDetailsResponse: data));
    }, failure: (statusCode, message) {
      emit(state.copyWith(getOrderDetailsState: RequestState.error));
    });
  }

  //* ADD order
  Future<void> addOrder(AddOrderBody addOrderBody, BuildContext context) async {
    showUpdatesLoading(context);
    emit(state.copyWith(addOrderState: RequestState.loading));
    var response = await _orderRepo.addOrder(addOrderBody);

    response.when(success: (data) {
      pop(context);
      context.navigatePush(SuccessOrderScreen(orderModel: data));
      emit(state.copyWith(addOrderState: RequestState.loaded));
    }, failure: (statusCode, message) {
      pop(context);
      emit(state.copyWith(addOrderState: RequestState.error));
    });
  }

  //*  reAdd Order
  Future<void> reAddOrder(int orderId,int page ,int status, {context}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(reAddOrderState: RequestState.loading));
    var response = await _orderRepo.reOrder(orderId);

    response.when(success: (data) async {
      showToast(msg: Strings.reAddOrderSuccess.tr());
      pop(context);
      emit(state.copyWith(reAddOrderState: RequestState.loaded));
      await getOrders(page,status);
    }, failure: (statusCode, message) {
      pop(context);
      emit(state.copyWith(reAddOrderState: RequestState.error));
    });
  }

  //*  update Order Status
  Future<void> updateOrderStatus(
      {required int orderId, required int status}) async {
    // *cancle order
    if (status == -1) {
      emit(state.copyWith(cancelOrderState: RequestState.loading));
    } else {
      emit(state.copyWith(updateOrderState: RequestState.loading));
    }
    var response =
        await _orderRepo.updateOrderStatus(orderId: orderId, status: status);

    response.when(success: (data) async {
      // *cancle order
      if (status == -1) {
        emit(state.copyWith(cancelOrderState: RequestState.loaded));
      } else {
        emit(state.copyWith(updateOrderState: RequestState.loaded));
      }
      await getOrderDetails(orderId);
    }, failure: (statusCode, message) {
      // *cancle order
      if (status == -1) {
        emit(state.copyWith(cancelOrderState: RequestState.error));
      } else {
        emit(state.copyWith(updateOrderState: RequestState.error));
      }
    });
  }

  //*  delete order
  Future<void> deleteOrder(int orderId) async {
    emit(state.copyWith(updateOrderState: RequestState.loading));
    var response = await _orderRepo.deleteOrder(orderId);

    response.when(success: (data) {
      emit(state.copyWith(updateOrderState: RequestState.loaded));
    }, failure: (statusCode, message) {
      emit(state.copyWith(updateOrderState: RequestState.error));
    });
  }

// * accept Order
  Future<void> acceptOrderDriver(
      {required int orderId, required int driverId, context}) async {
    emit(state.copyWith(updateOrderState: RequestState.loading));
    var response = await _orderRepo.acceptOrderDriver(
        orderId: orderId, driverId: driverId);

    response.when(success: (data) {
      emit(state.copyWith(updateOrderState: RequestState.loaded));
      getOrderDetails(orderId);
      sl<DriverCubit>().getHomeDriver(currentUser!.user.id);
    }, failure: (statusCode, message) {
      emit(state.copyWith(updateOrderState: RequestState.error));
    });
  }
// * get Orders by Driver Id

  // * get Orders by Driver Id
  Future<void> getOrdersByDriverId(int driverId, int page) async {
    emit(state.copyWith(getOrdersState: RequestState.loading));
    var response =
        await _orderRepo.getOrdersByDriverId(driverId: driverId, page: page);
    response.when(success: (data) {
      emit(state.copyWith(
          getOrdersState: RequestState.loaded, orderDriverResponse: data));
    }, failure: (statusCode, message) {
      emit(state.copyWith(getOrdersState: RequestState.error));
    });
  }

  ///* markers

  List<Marker> listMarker = const [];
  Future drawMarkers({context, latDriver, lngDriver, latUser, lngUser}) async {
    Uint8List markerIconUser =
        await getBytesFromAsset('assets/images/marker.png', 120);

    Uint8List markerIconDriver =
        await getBytesFromAsset('assets/images/mylocation.png', 120);

    emit(state.copyWith(getMarkerState: RequestState.loading));
    listMarker = [
      Marker(
          markerId: MarkerId('1'),
          position: LatLng(latUser, lngUser),
          icon: BitmapDescriptor.fromBytes(markerIconUser),
          infoWindow: InfoWindow(
            title: Strings.locationUser.tr(),
          )),
      Marker(
          markerId: MarkerId('2'),
          position: LatLng(latDriver, lngDriver),
          icon: BitmapDescriptor.fromBytes(markerIconDriver),
          infoWindow: InfoWindow(
            title: Strings.locationDriver.tr(),
          )),
    ];
    emit(state.copyWith(getMarkerState: RequestState.loading));
  }

  //** format image marker */
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
