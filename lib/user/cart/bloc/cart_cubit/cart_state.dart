part of 'cart_cubit.dart';

class CartState extends Equatable {
  final RequestState? addCartState;
  final RequestState? changeDataState;

  final RequestState? getCartsaState;

  final CartResponse? cartResponse;

  const CartState({
    this.addCartState ,
    this.changeDataState,
    this.getCartsaState = RequestState.loading,
    this.cartResponse ,
  });

  CartState copyWith({
    RequestState? addCartState,
    RequestState? changeDataState,
    RequestState? getCartsaState,
    CartResponse? cartResponse,
  }) {
    return CartState(
      addCartState: addCartState ?? this.addCartState,
      changeDataState: changeDataState ?? this.changeDataState,
      getCartsaState: getCartsaState ?? this.getCartsaState,
      cartResponse: cartResponse ?? this.cartResponse,
    );
  }

  @override
  List<Object?> get props => [addCartState, changeDataState, getCartsaState, cartResponse];
}
