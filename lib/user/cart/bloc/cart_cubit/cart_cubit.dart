import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/user/cart/data/models/add_cart_body_request.dart';
import 'package:wajed_app/user/cart/data/models/cart_model.dart';
import '../../data/repo/cart_repo.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final BaseCart _baseCart;
  CartCubit(this._baseCart) : super(const CartState());
  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);

  ///* ========================================== .  add Quntity
  int quntity = 1;
  Map<int, int> cartsFound = {};
  Map<int, int> quantitiesMap = {};
  Map<int, double> prices = {};
  double total = 0.0;
  addQuntity({isAdd}) {
    emit(state.copyWith(changeDataState: RequestState.loading));
    if (isAdd) {
      quntity++;
    } else {
      if (quntity > 1) {
        quntity--;
      }
    }
    emit(state.copyWith(changeDataState: RequestState.loaded));
  }

// * =========================================== . add Cart
  Future addCart(AddCartBodyRequest cartBodyRequest, {context}) async {
    cartsFound.containsValue(cartBodyRequest.productId)
        ? cartsFound.remove(cartBodyRequest.productId)
        : cartsFound
            .addAll({cartBodyRequest.productId: cartBodyRequest.productId});
    emit(state.copyWith(addCartState: RequestState.loading));
    var response = await _baseCart.addCart(cartBodyRequest);

    response.when(success: (data) {
      showToast(msg: "تم الاضافة الي السلة ", color: Colors.green);
      emit(state.copyWith(
        addCartState: RequestState.loaded,
      ));
    }, failure: (code, message) {
      debugPrint("$code===================> addCart Status code");
      emit(state.copyWith(addCartState: RequestState.error));
    });
  }

  ///* ========================================== . get Carts
  Future getCarts(String userId, String code, {isUpdateCart = false}) async {
    prices.clear();
    cartsFound.clear();
    if (!isUpdateCart) {
      emit(state.copyWith(getCartsaState: RequestState.loading));
    }
    var response = await _baseCart.getCarts(userId, code);
    response.when(success: (data) {
      // get quntites
      for (CartDeatails element in data.carts) {
        cartsFound.addAll({element.product.id: element.product.id});
        // quantities.add(element.cart.quantity);
        quantitiesMap.addAll({element.product.id: element.cart.quantity});
        prices.addAll({element.product.id: element.cart.cost});
      }

      total = data.totalCost;
      if (!isUpdateCart) {
        emit(state.copyWith(
            getCartsaState: RequestState.loaded, cartResponse: data));
      } else {
        emit(state.copyWith(cartResponse: data));
      }
    }, failure: (code, message) {
      debugPrint("$code===================> getCarts Status code");
      if (!isUpdateCart) {
        emit(state.copyWith(getCartsaState: RequestState.error));
      }
    });
  }

// * handle Quntityies
  add(index, price, id, productId) {
    // total = 0.0;
    emit(state.copyWith(changeDataState: RequestState.loading));
    // quantities[index]++;
    quantitiesMap[productId] = quantitiesMap[productId]! + 1;
    prices[productId] = price * quantitiesMap[productId];

    updateCart(quantitiesMap[productId]!, id);
    emit(state.copyWith(changeDataState: RequestState.loaded));
  }

  mins(index, price, id, productId) {
    emit(state.copyWith(changeDataState: RequestState.loading));
    if (quantitiesMap[productId]! > 1) {
      prices[productId] = price * quantitiesMap[productId];
      quantitiesMap[productId] = quantitiesMap[productId]! - 1;

      updateCart(quantitiesMap[productId]!, id);
    }

    emit(state.copyWith(changeDataState: RequestState.loaded));
  }

  ///* =============================================== .  update Cart
  Future updateCart(int quntity, int id) async {
    prices.clear();
    cartsFound.clear();
    emit(state.copyWith(changeDataState: RequestState.loading));
    var response = await _baseCart.updateCart(quantity: quntity, id: id);
    response.when(success: (data) {
      getCarts(currentUser!.user.id, "", isUpdateCart: true);
      emit(state.copyWith(changeDataState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> updateCart Status code");
      emit(state.copyWith(changeDataState: RequestState.error));
    });
  }

 ///* =============================================== .  delete Cart
  Future deleteCart( int cartId) async {
    prices.clear();
    cartsFound.clear();
    emit(state.copyWith(changeDataState: RequestState.loading));
    var response = await _baseCart.deleteCart(cartId: cartId);
    response.when(success: (data) {
      getCarts(currentUser!.user.id, "", isUpdateCart: false);
      emit(state.copyWith(changeDataState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> deleteCart Status code");
      emit(state.copyWith(changeDataState: RequestState.error));
    });
  }


}
