
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerCard({height, width}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: width,
      color: Colors.white,
    ),
  );
}
