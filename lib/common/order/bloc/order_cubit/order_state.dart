part of 'order_cubit.dart';

class OrderState extends Equatable {
  final RequestState getOrdersState;
  final OrderResponse? orderResponse;
  final RequestState getOrderDetailsState;
  final OrderDetailsResponse? orderDetailsResponse;
  final OrdersMarketResponse? ordersMarket;

  /// * states
  final RequestState? addOrderState;
  final RequestState? reAddOrderState;
  final RequestState? updateOrderState;
  final RequestState? cancelOrderState;
  final RequestState? getOrdersMarketState;
  final OrderDriverResponse? orderDriverResponse;


  /// * marker 
  final RequestState? getMarkerState;

  const OrderState(
      {this.getOrdersState = RequestState.loading,
      this.orderResponse ,
      this.addOrderState,
      this.reAddOrderState,
      this.updateOrderState,
      this.getOrderDetailsState = RequestState.loading,
      this.orderDetailsResponse,
      this.cancelOrderState,
      this.ordersMarket,
       this.getMarkerState,
      this.orderDriverResponse,
      this.getOrdersMarketState});

  // * copy with

  OrderState copyWith(
          {RequestState? getOrdersState,
          OrderResponse? orderResponse,
          RequestState? addOrderState,
          RequestState? reAddOrderState,
          RequestState? updateOrderState,
          RequestState? getOrderDetailsState,
          OrderDetailsResponse? orderDetailsResponse,
          RequestState? cancelOrderState,
          OrdersMarketResponse? ordersMarket,
          RequestState? getOrdersMarketState,
          OrderDriverResponse? orderDriverResponse,
            final RequestState? getMarkerState
          }) =>
      OrderState(
          getOrdersState: getOrdersState ?? this.getOrdersState,
          orderResponse: orderResponse ?? this.orderResponse,
          addOrderState: addOrderState ?? this.addOrderState,
          reAddOrderState: reAddOrderState ?? this.reAddOrderState,
          updateOrderState: updateOrderState ?? this.updateOrderState,
          getOrderDetailsState:
              getOrderDetailsState ?? this.getOrderDetailsState,
          orderDetailsResponse:
              orderDetailsResponse ?? this.orderDetailsResponse,
          cancelOrderState: cancelOrderState ?? this.cancelOrderState,
          ordersMarket: ordersMarket ?? this.ordersMarket,
          getOrdersMarketState:
              getOrdersMarketState ?? this.getOrdersMarketState,
          orderDriverResponse: orderDriverResponse ?? this.orderDriverResponse,
          getMarkerState: getMarkerState ?? this.getMarkerState
          
          
          );

  @override
  List<Object?> get props => [
        getOrdersState,
        orderResponse,
        addOrderState,
        reAddOrderState,
        updateOrderState,
        getOrderDetailsState,
        orderDetailsResponse,
        cancelOrderState,
        ordersMarket,
        getOrdersMarketState,
        orderDriverResponse,
        getMarkerState
      ];
}
