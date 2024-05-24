part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final RequestState? getCategoriesState;
  final List<CategoryModel> categories;
  final RequestState? addCategoryState;

  const CategoryState({
    this.addCategoryState,
    this.getCategoriesState,
    this.categories=const [],
  });
  @override
  List<Object?> get props => [addCategoryState,categories,getCategoriesState];
}
