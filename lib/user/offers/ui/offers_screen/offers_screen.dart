import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/common_widgets/image_network.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/user/offers/data/models/offfer_model.dart';



class OffersScreen extends StatefulWidget {
  final OfferModel offer;
  const OffersScreen({super.key, required this.offer});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0.h,
          automaticallyImplyLeading: false,
          pinned: true,
          floating: false,
          snap: false,
          leading: BackButton(),
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding:
                  EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              title: Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.green, width: 1))),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 15.w,
                    ),
                    horizontalSpace(10.w),
                    Expanded(
                        child: Text(
                      Strings.searchToMarket,
                      style: TextStyles.textStyleFontBold12kDarkGrey,
                    ))
                  ],
                ),
              ),
              collapseMode: CollapseMode.parallax,
              background: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ImageNetworkWidget(
                  imageUrl: widget.offer.image,
                  height: 250.h,
                  width: double.infinity,
                ),
              )),
        ),
        SliverList.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Container(
                height: 100.h,
                color: Colors.green,
                margin: EdgeInsets.all(5.h),
                width: double.infinity,
              );
            })
      ],
    ));
  }
}
