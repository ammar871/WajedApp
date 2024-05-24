
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double hieght;
  final Color color;
  const DividerWidget({
    super.key,
    required this.hieght,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hieght,
      color: color,
    );
  }
}

