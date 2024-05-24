
import 'package:flutter/material.dart';



import '../../constants/layout/app_radius.dart';
import '../../constants/layout/app_sizes.dart';
import '../../constants/layout/palette.dart';


class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    super.key,
 
  });



  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const BoxDecoration(
        color: Palette.white,
        borderRadius: AppRadius.r10,
        boxShadow: [
          BoxShadow(
            color: Palette.kShadowColor,
            blurRadius: AppSize.s10,
          )
        ],
      ),
      child: const Material()
      //   child: InkWell(
      //     onTap: () {
          
      //     },
      //     borderRadius: AppRadius.r10,
      //     child: ClipPath(
      //       clipper: const ShapeBorderClipper(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: AppRadius.r10,
      //         ),
      //       ),
      //       child: Container(
      //         padding: const EdgeInsets.symmetric(
      //           vertical: AppSize.s10,
      //           horizontal: AppSize.s12,
      //         ),
      //         decoration: const BoxDecoration(
      //           // border: Border(
      //           //   right: BorderSide(
      //           //     color: Palette.restaurantColor,
      //           //     width: AppSize.s8,
      //           //   ),
      //           // ),
      //           border: BorderDirectional(
      //             start: BorderSide(
      //               color: Palette.mainColor,
      //               width: AppSize.s8,
      //             ),
      //           ),
      //         ),
      //         child: IntrinsicHeight(
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Expanded(
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         ClipRRect(
      //                           borderRadius: AppRadius.r10,
      //                           child: CachedNetworkImage(
      //                             imageUrl: "kTestImageUrl",
      //                             width: AppSize.s80,
      //                             height: AppSize.s80,
      //                             fit: BoxFit.cover,
      //                           ),
      //                         ),

      //                         const SizedBox(width: AppSize.s10),
      //                         // Details
      //                         Expanded(
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text(
      //                                 order.id.toString(),
      //                                 style: context.titleM.copyWith(
      //                                   color: Palette.kOrangeColor,
      //                                   fontWeight: FontWeight.bold,
      //                                 ),
      //                               ),
      //                               Text(
      //                                 "ناجح",
      //                                 style: context.titleM.copyWith(
      //                                   color: Palette.mainColor,
      //                                 ),
      //                               ),
      //                               Text(
      //                                 "01 سبتمبر 2022 : 02:30 PM",
      //                                 style: context.titleS.copyWith(
      //                                   color: Palette.kDarkGrey,
      //                                 ),
      //                               ),
      //                               Text(
      //                                 "${context.translate("order_number")} ${order.id}",
      //                                 style: context.titleS.copyWith(
      //                                   color: Palette.kDarkGrey,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     const SizedBox(height: 10),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Expanded(
      //                           child: TextButton.icon(
      //                             onPressed: () {},
      //                             style: TextButton.styleFrom(
      //                               padding: const EdgeInsets.symmetric(
      //                                 vertical: AppSize.s2,
      //                               ),
      //                             ),
      //                             icon: SvgPicture.asset(AppAssets.reOrder),
      //                             label: Text(
      //                               context.translate("reorder"),
      //                               // overflow: TextOverflow.ellipsis,
      //                               style: context.titleM.copyWith(
      //                                 color: Palette.kDarkGrey,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                         Expanded(
      //                           child: TextButton.icon(
      //                             onPressed: () {},
      //                             style: TextButton.styleFrom(
      //                               padding: const EdgeInsets.symmetric(
      //                                 vertical: AppSize.s2,
      //                               ),
      //                             ),
      //                             icon: SvgPicture.asset(AppAssets.rateSmile),
      //                             label: Text(
      //                               context.translate("rate_order"),
      //                               // overflow: TextOverflow.ellipsis,
      //                               style: context.titleM.copyWith(
      //                                 color: Palette.kDarkGrey,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               // Arrow icon
      //               const SizedBox(
      //                 width: AppSize.s30,
      //                 child: Center(
      //                   child: Icon(
      //                     CupertinoIcons.forward,
      //                     size: AppSize.s22,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
