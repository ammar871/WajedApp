import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wajed_app/core/constants/layout/screen_size.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../constants/layout/app_assets.dart';
import '../../constants/layout/app_radius.dart';
import '../../constants/layout/app_sizes.dart';
import '../../constants/layout/palette.dart';

class HomeSearchBar extends StatefulWidget implements PreferredSizeWidget {
 final bool enable ;
  final Function(String)? onChange;

  const HomeSearchBar({super.key,required this.enable,  this.onChange});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(AppSize.s20);
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late TextEditingController _searchController;

  bool showClearButton = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = const OutlineInputBorder(
      borderRadius: AppRadius.r10,
      borderSide: BorderSide.none,
    );
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.getHorizontalPadding(),
        vertical: AppSize.s10,
      ),
      decoration: const BoxDecoration(
        color: Palette.white,
        borderRadius: AppRadius.r10,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(210, 221, 221, 221),
            blurRadius: 5,
            offset: Offset(1.0, 3.0),
          ),
        ],
      ),
      child: TextFormField(
        enabled: widget.enable,
        controller: _searchController,
        style: const TextStyle(
          height: 1.2,
        ),
        onChanged: (val) {
          if (val.isNotEmpty) {
            showClearButton = true;
            widget.onChange!(val);
          } else {
            showClearButton = false;
          }
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: Strings.whatAreYouLookingFor.tr(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 1),

          hintStyle: const TextStyle(
            color: Palette.fontGreyColor,
          ),
          prefixIcon: Align(
            // alignment: Alignment.centerRight,
            widthFactor: 1.0,
            child: SvgPicture.asset(
              AppAssets.search,
              width: AppSize.s25,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(maxWidth: AppSize.s40),
          suffixIcon: !showClearButton
              ? null
              : Padding(
                  padding: const EdgeInsetsDirectional.only(end: AppSize.s12),
                  child: SizedBox(
                    width: AppSize.s25,
                    height: AppSize.s25,
                    child: MaterialButton(
                      onPressed: () {
                        _searchController.clear();
                        showClearButton = false;
                        setState(() {});
                      },
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.close,
                        size: AppSize.s20,
                        color: Palette.kDarkGrey,
                      ),
                    ),
                  ),
                ),
          // isDense: true,
          border: outlineInputBorder,
          errorBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder,
        ),
      ),
    );
  }
}
