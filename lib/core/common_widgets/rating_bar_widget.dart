import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';

class RatingBarWidget extends StatelessWidget {
  final double rate, size;
  const RatingBarWidget({super.key, required this.rate, required this.size});

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      minRating: 1,
      maxRating: 5,
      initialRating: rate.toDouble(),
      itemSize: size,
      ratingWidget: RatingWidget(
        full: const Icon(
          Icons.star,
          color: Palette.kOrangeColor,
        ),
        half: const Icon(Icons.star),
        empty: const Icon(
          Icons.star,
          color: Colors.grey,
        ),
      ),
      onRatingUpdate: (val) {},
    );
  }
}
