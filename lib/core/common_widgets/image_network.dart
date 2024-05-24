import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:wajed_app/core/common_widgets/shimmer_photo.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double? height, width;
  final BoxFit? fit;
  final Widget? errorWidget;
  const ImageNetworkWidget(
      {super.key,this.errorWidget, required this.imageUrl, this.height, this.width, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ApiConstants.imageUrl(imageUrl),
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      errorWidget: (context, url, error) =>errorWidget?? const SizedBox(),
      placeholder: (context, url) => shimmerCard(height: height, width: width),
    );
  }
}
