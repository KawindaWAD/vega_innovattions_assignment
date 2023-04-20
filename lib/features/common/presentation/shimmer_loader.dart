import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Cash network image loading widget
Widget shimmerLoader({Widget? child, Color? baseColor, Color? highlightColor }) {
  return Shimmer.fromColors(
    baseColor: baseColor?? Colors.grey.shade100,
    highlightColor: highlightColor?? Colors.white,
    child: child ??
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
        ),
  );
}