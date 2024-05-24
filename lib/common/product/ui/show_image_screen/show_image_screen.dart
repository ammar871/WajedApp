import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/api_constatns.dart';

class ShowImageScreen extends StatelessWidget {
  final String image;
  const ShowImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
     PhotoView(
      imageProvider:  NetworkImage(ApiConstants.imageUrl(image)),
    ),
    Positioned(
        right: 30.w,
        top: 50.h,
        child: GestureDetector(
          onTap: () {
            pop(context);
          },
          child:  Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        )),
      ],
    );
  }
}
