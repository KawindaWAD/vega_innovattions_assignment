import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/presentation/shimmer_loader.dart';

class ArticleCardShimmer extends StatelessWidget {
  const ArticleCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                left: 15,
                top: 12.h,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 10,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: shimmerLoader(),
                    ),
                    5.verticalSpace,
                    Container(
                      width: double.infinity,
                      height: 10,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: shimmerLoader(),
                    ),
                    5.verticalSpace,
                    Container(
                      width: Random().nextInt(150) + 50,
                      height: 10,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: shimmerLoader(),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12.h,
                left: 15,
                child: Container(
                  width: 80,
                  height: 20,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: shimmerLoader(),
                ),
              ),
              Positioned(
                bottom: 12.h,
                right: 15,
                child: Container(
                  width: 120,
                  height: 20,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: shimmerLoader(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}