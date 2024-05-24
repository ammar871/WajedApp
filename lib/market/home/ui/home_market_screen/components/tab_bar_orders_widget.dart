

import 'package:flutter/material.dart';
import 'package:wajed_app/common/app/data/models/bas_models/tab_bar_item_model.dart';

import '../../../../../core/constants/layout/palette.dart';

class TabBarOrdersWidget extends StatelessWidget {
  final Function(int) onTap;
 final List<TabBarItemModel> list;
  const TabBarOrdersWidget({super.key, required this.onTap,required this.list});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelColor: Palette.restaurantColor,
      indicatorColor: Palette.restaurantColor,
      onTap: onTap,
      tabs: list
          .map((e) => Tab(
                text: e.title,
              ))
          .toList(),
    );
  }
}
