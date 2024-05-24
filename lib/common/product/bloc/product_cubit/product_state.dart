part of 'product_cubit.dart';

class ProductState extends Equatable {
  final RequestState getProcdutesByCategoryIdState;
  final ProductsResponse? productsResponse;

  final RequestState getProductDetailsState;
  final ProductDetailsResponse? productDetailsResponse;

  final RequestState? addProductState;
  final RequestState? uploadImageState;
  final List<String> images;
  final RequestState? addOptionsState;

  const ProductState(
      {this.getProcdutesByCategoryIdState = RequestState.loading,
      this.productsResponse,
      this.getProductDetailsState = RequestState.loading,
      this.addProductState,
      this.productDetailsResponse,
      this.uploadImageState,
      this.images = const [],
      this.addOptionsState });

  ProductState copyWith(
      {RequestState? getProcdutesByCategoryIdState,
      ProductsResponse? productsResponse,
      RequestState? getProductDetailsState,
      ProductDetailsResponse? productDetailsResponse,
      final RequestState? addProductState,
      final RequestState? uploadImageState,
      final List<String>? images,
      final RequestState? addOptionsState}) {
    return ProductState(
        getProcdutesByCategoryIdState:
            getProcdutesByCategoryIdState ?? this.getProcdutesByCategoryIdState,
        productsResponse: productsResponse ?? this.productsResponse,
        getProductDetailsState:
            getProductDetailsState ?? this.getProductDetailsState,
        productDetailsResponse:
            productDetailsResponse ?? this.productDetailsResponse,
        addProductState: addProductState ?? this.addProductState,
        uploadImageState: uploadImageState ?? this.uploadImageState,
        images: images ?? this.images,
        addOptionsState: addOptionsState ?? this.addOptionsState);
  }

  @override
  List<Object?> get props => [
        getProcdutesByCategoryIdState,
        productsResponse,
        getProductDetailsState,
        productDetailsResponse,
        addProductState,
        uploadImageState,
        images,
        addOptionsState
      ];
}
