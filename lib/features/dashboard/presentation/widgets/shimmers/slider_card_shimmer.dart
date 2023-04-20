import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/presentation/shimmer_loader.dart';

class SliderCardShimmer extends StatelessWidget {

  const SliderCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
            clipBehavior: Clip.antiAlias,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Colors.grey.shade300
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  //bottom: 30.h,
                  left: 15,
                  right: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 15,
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
                          height: 20,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: shimmerLoader(),
                      ),
                      5.verticalSpace,
                      Container(
                          width: 200.w,
                          height: 20,
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
                  bottom: 20.h,
                  left: 15,
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
                      7.verticalSpace,
                      Container(
                          width: 150.w,
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
              ],
            )
        );
      },
    );
  }
}