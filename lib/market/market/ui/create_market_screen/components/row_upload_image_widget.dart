import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/core/theming/styles.dart';

import '../../../../../core/common_widgets/image_network.dart';
import '../../../../../core/constants/layout/palette.dart';

class RowUploadImageWidget extends StatelessWidget {
  final String title;
  final String? image;
  final bool loading;
  final VoidCallback onTap;
  const RowUploadImageWidget({
    super.key,
    required this.title,
    this.image,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyles.textStyleFontRegular16greyColor,
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              loading
                  ? SizedBox(
                      height: 60.w,
                      width: 60.w,
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: Palette.restaurantColor),
                      ),
                    )
                  : GestureDetector(
                      onTap: onTap,
                      child: Container(
                        height: 60.w,
                        width: 60.w,
                        padding: EdgeInsets.all(image == null ? 10 : 0).w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.r),
                            color: Palette.restaurantColor),
                        child: image == null
                            ? SvgPicture.asset(
                                "assets/icons/photo.svg",
                                width: 40.w,
                                height: 40,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(7.r),
                                child: ImageNetworkWidget(
                                    height: 60.w,
                                    width: 60.w,
                                    fit: BoxFit.cover,
                                    imageUrl: image!),
                              ),
                      ),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
