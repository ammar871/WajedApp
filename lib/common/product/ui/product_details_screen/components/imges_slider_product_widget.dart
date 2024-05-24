import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';

import '../../../../../core/common_widgets/image_network.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../show_image_screen/show_image_screen.dart';

class ImgesSliderProductWidget extends StatefulWidget {
  final List<String> images;
  const ImgesSliderProductWidget({
    super.key,
    required this.images,
  });

  @override
  State<ImgesSliderProductWidget> createState() =>
      _ImgesSliderProductWidgetState();
}

class _ImgesSliderProductWidgetState extends State<ImgesSliderProductWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
           
            height: context.height / 3,
            width: context.width,
            child: CarouselSlider(
              
              items: List.generate(
                widget.images.length,
                (index) {
                  final imageUrl = widget.images[index];
                  return GestureDetector(
                    onTap: () {
                      context.navigatePush(ShowImageScreen(image: imageUrl));
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: ImageNetworkWidget(
                        imageUrl: imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                autoPlay: false,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 1.0,
                viewportFraction: 1.0,
              ),
            )),

        /// * indecator
        verticalSpace(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              widget.images.length,
              (index) => Container(
                    height: 10.w,
                    width: 10.w,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index ? Palette.restaurantColor : Colors.grey),
                  )),
        )
      ],
    );
  }
}
