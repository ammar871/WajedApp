import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wajed_app/common/app/data/repo/app_repo.dart';
import 'package:wajed_app/common/product/data/models/productes_response.dart';
import 'package:wajed_app/common/product/ui/product_details_screen/product_details_screen.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/market/home/ui/navigation_screen/navigation_screen.dart';
import '../../../../core/services/services_locator.dart';
import '../../data/models/add_options_body.dart';
import '../../data/models/add_product_body.dart';
import '../../data/models/product_details_response.dart';
import '../../data/models/product_model.dart';
import '../../data/repo/product_repo.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final BaseProduct _productRepo;
  final BaseApp _appRepo;
  ProductCubit(this._productRepo, this._appRepo) : super(const ProductState());
  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);

  /// * ============================================= . getProductsByCategoryId ===================
  Future<void> getProductsByCategoryId({
    categoryId,
    userId,
    marketId,
    page,
  }) async {
    emit(state.copyWith(getProcdutesByCategoryIdState: RequestState.loading));
    var response = await _productRepo.getProductsByCategoryId(
        categoryId: categoryId, userId: userId, page: page,marketId: marketId);

    response.when(success: (data) {
      emit(state.copyWith(
          getProcdutesByCategoryIdState: RequestState.loaded,
          productsResponse: data));
    }, failure: (code, message) {
      debugPrint(
          "$code===================> getProductsByCategoryId Status code");
      emit(state.copyWith(getProcdutesByCategoryIdState: RequestState.error));
    });
  }

  /// * ============================================= . getProductDetails ===================
  final controller = TextEditingController();
  List<int> idsOptipns = [];
  Future<void> getProductDetails({productId, userId}) async {
    emit(const ProductState(getProductDetailsState: RequestState.loading));
    var response = await _productRepo.getProductDetails(
        productId: productId, userId: userId);

    response.when(success: (data) {
      // ignore: unused_local_variable
      for (var element in data.options) {
        idsOptipns.add(0);
      }
      emit(ProductState(
          getProductDetailsState: RequestState.loaded,
          productDetailsResponse: data));
    }, failure: (code, message) {
      debugPrint("$code===================> getProductDetails Status code");
      emit(const ProductState(getProductDetailsState: RequestState.error));
    });
  }

  /// * ============================================= . addProduct ===================
  Future<void> addProduct(AddProductBody productBody, {context}) async {
    emit(const ProductState(addProductState: RequestState.loading));
    var response = await _productRepo.addProduct(productBody);

    response.when(success: (data) {
      pushPage(context, const NavigationScreen());
      emit(const ProductState(addProductState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> addProduct Status code");
      emit(const ProductState(addProductState: RequestState.error));
    });
  }

  /// * ============================================== update product

  Future<void> updateProduct(ProductModel productModel, {context}) async {
    emit(const ProductState(addProductState: RequestState.loading));
    var response = await _productRepo.updateProduct(productModel);
    response.when(success: (data) {
      pushPage(context, const NavigationScreen());
      emit(const ProductState(addProductState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> updateProduct Status code");
      emit(const ProductState(addProductState: RequestState.error));
    });
  }

 Future getImagesForUpdaetProduct(String imagesProduct)async {
    emit(state.copyWith(uploadImageState: RequestState.loading));
    images = imagesProduct.split("#");
  
    emit(state.copyWith(uploadImageState: RequestState.loaded,images: images));
  }

  /// * ================================================================= delete product
  Future<void> deleteProduct(int productId, {context}) async {
    emit(const ProductState(addProductState: RequestState.loading));
    var response = await _productRepo.deleteProduct(productId);
    response.when(success: (data) {
      pushPage(context, const NavigationScreen());
      emit(const ProductState(addProductState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> deleteProduct Status code");
      emit(const ProductState(addProductState: RequestState.error));
    });
  }

  /// * ============================= . upload image

  List<String> images = [];
  Future<void> uploadImage() async {
    emit(state.copyWith(uploadImageState: RequestState.loading));
    final picker = ImagePicker();
    File image;
    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      var response = await _appRepo.uploadIamage(image);
      response.when(success: (data) {
        images.add(data);
        emit(state.copyWith(uploadImageState: RequestState.loaded));
      }, failure: (code, message) {
        debugPrint("$code===================> uploadImage Status code");
        emit(state.copyWith(uploadImageState: RequestState.error));
      });
    }
  }

  /// * ============================= . remove image

  void removeImage(int index) {
    emit(state.copyWith(uploadImageState: RequestState.loading));
    images.removeAt(index);
    emit(state.copyWith(uploadImageState: RequestState.loaded));
  }

  /// * ================================================= add Options Product
  Future<void> addOptionsProduct(
    BuildContext context,
    AddOptionsBody optionsResponse,
  ) async {
    emit(state.copyWith(addOptionsState: RequestState.loading));
    var response = await _productRepo.addGroupProduct(optionsResponse);
    response.when(success: (data) {
      pushPage(
          context,
          BlocProvider(
            create: (context) => sl<ProductCubit>(),
            child: ProductDetailsScreen(
                productId: optionsResponse.groupOptions.productId),
          ));
      emit(state.copyWith(addOptionsState: RequestState.loaded));
    }, failure: (code, message) {
      debugPrint("$code===================> addOptionsProduct Status code");
      emit(state.copyWith(addOptionsState: RequestState.error));
    });
  }
}
