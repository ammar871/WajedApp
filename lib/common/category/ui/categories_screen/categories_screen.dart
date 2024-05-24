import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/category/bloc/cubit/category_cubit.dart';
import 'package:wajed_app/common/category/data/models/category_model.dart';
import 'package:wajed_app/common/category/ui/add_category_screen/add_category_screen.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/theming/container_styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import '../../../../core/common_widgets/circular_progress.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import '../../../../market/home/bloc/cubit/home_market_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(
          Strings.categories.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.restaurantColor,
        onPressed: () {
          context.navigatePush(AddCategoryScreen(marketId: marketDetails!.id));
        },
        child: Icon(
          Icons.add,
          color: Palette.white,
          size: 30.w,
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<CategoryCubit>()
          ..getCategoriesMarket(context: context, marketId: marketDetails!.id),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            switch (state.getCategoriesState) {
              case RequestState.loading:
                return const CustomCircularProgress();
              case RequestState.loaded:
                return ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      CategoryModel category = state.categories[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        margin: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        decoration: ContainerStyles.elevationContainner,
                        height: 80.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isAraic() ? category.nameAr : category.nameEng,
                              style: TextStyles.textStyleFontBold20Black,
                            ),
                            GestureDetector(
                                onTapDown: (details) async {
                                  final offset = details.globalPosition;
                                  showPopMenu(
                                      postion: RelativeRect.fromLTRB(
                                        offset.dx,
                                        offset.dy,
                                        context.width - offset.dx,
                                        context.height - offset.dy,
                                      ),
                                      context: context,
                                      items: [
                                        PopupMenuItem(
                                            onTap: () {
                                              context.navigatePush(
                                                  AddCategoryScreen(
                                                marketId: marketDetails!.id,
                                                isUpdate: true,
                                                categoryModel: category,
                                              ));
                                            },
                                            child: Text(
                                              Strings.edite.tr(),
                                            )),
                                        PopupMenuItem(
                                          onTap: () {
                                            deleteDataDialog(
                                                context: context,
                                                title: Strings.sureDelete.tr(),
                                                value: isAraic()
                                                    ? category.nameAr
                                                    : category.nameEng,
                                                onDelete: () {
                                                  pop(context);
                                                  CategoryCubit.get(context)
                                                      .deleteCategory(
                                                          category.id, context)
                                                      .then((value) {
                                                    HomeMarketCubit.get(context)
                                                        .getHomeMarket(
                                                            currentUser!
                                                                .user.id);
                                                  });
                                                });
                                          },
                                          child: Text(
                                            Strings.delete.tr(),
                                          ),
                                        ),
                                      ],
                                      key: _key);
                                },
                                child: Icon(
                                  Icons.more_vert_outlined,
                                  size: 20.w,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                      );
                    });
              case RequestState.error:
                return const Text("error");
              default:
                return const Text("error");
            }
          },
        ),
      ),
    );
  }
}
