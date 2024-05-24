import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/common/category/data/models/update_category_body.dart';
import 'package:wajed_app/common/category/data/repo/categories_repo.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/home/bloc/cubit/home_market_cubit.dart';
import '../../../../core/services/services_locator.dart';
import '../../data/models/add_category_body_request.dart';
import '../../data/models/category_model.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryBase _baseCategory;
  CategoryCubit(this._baseCategory) : super(const CategoryState());
  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);

  /// * get categories market
  Future<void> getCategoriesMarket({context, marketId}) async {
    emit(const CategoryState(getCategoriesState: RequestState.loading));
    final result = await _baseCategory.getCategoriesMarket(marketId);
    result.when(success: (data) {
      emit(CategoryState(
          getCategoriesState: RequestState.loaded, categories: data));
    }, failure: (code, message) {
      emit(const CategoryState(getCategoriesState: RequestState.error));
    });
  }

// *  add Category
  Future<void> addCategory(
      AddCategoryBodyRequest addCategoryBodyRequest, context) async {
    emit(const CategoryState(addCategoryState: RequestState.loading));
    final result = await _baseCategory.addCategory(addCategoryBodyRequest);
    result.when(success: (data) async {
      showToast(color: Colors.green, msg: Strings.addedSuccese.tr());

      emit(const CategoryState(addCategoryState: RequestState.loaded));

      await sl<HomeMarketCubit>().getHomeMarket(currentUser!.user.id);
      await sl<HomeMarketCubit>().changeIndexNav(2);
      pop(context);
    }, failure: (code, message) {
      emit(const CategoryState(addCategoryState: RequestState.error));
    });
  }

// *  update Category

  Future<void> updateCategory(
      UpdateCategoryBody updateCategoryBody, BuildContext context) async {
    emit(const CategoryState(addCategoryState: RequestState.loading));
    final result = await _baseCategory.updateCategory(updateCategoryBody);
    result.when(success: (data) async {
      showToast(color: Colors.green, msg: Strings.updaedSuccess.tr());

      emit(const CategoryState(addCategoryState: RequestState.loaded));
      await getCategoriesMarket(context: context, marketId: marketDetails!.id);

      pop(context);
      await sl<HomeMarketCubit>().getHomeMarket(currentUser!.user.id);
      await sl<HomeMarketCubit>().changeIndexNav(2);
    }, failure: (code, message) {
      emit(const CategoryState(addCategoryState: RequestState.error));
    });
  }

  // *  delete Category

  Future<void> deleteCategory(categoryId, context) async {
    emit(const CategoryState(addCategoryState: RequestState.loading));
    final result = await _baseCategory.deleteCategory(categoryId);
    result.when(success: (data) async {
      showToast(color: Colors.green, msg: Strings.deletedSuccess.tr());

      emit(const CategoryState(addCategoryState: RequestState.loaded));
      getCategoriesMarket(context: context, marketId: marketDetails!.id);
      sl<HomeMarketCubit>().getHomeMarket(currentUser!.user.id);
      await sl<HomeMarketCubit>().changeIndexNav(2);
    }, failure: (code, message) {
      emit(const CategoryState(addCategoryState: RequestState.error));
    });
  }
}
