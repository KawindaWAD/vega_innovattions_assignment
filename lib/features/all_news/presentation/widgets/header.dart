import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/functions/change_status_bar.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../common/presentation/bounce_widget.dart';
import '../../../common/presentation/shimmer_loader.dart';
import 'category_list.dart';
import 'search_bar.dart';

class AllNewsHeaderDelegate extends SliverPersistentHeaderDelegate {
  const AllNewsHeaderDelegate();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    return Container(
      color: AppColors.white,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: progress,
            child: const ColoredBox(
              color: AppColors.red,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.lerp(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              const EdgeInsets.only(bottom: 16),
              progress,
            ),
            alignment: Alignment.lerp(
              Alignment.bottomLeft,
              Alignment.bottomCenter,
              progress,
            ),
            child: Text(
              'All News',
              style: TextStyle.lerp(
                headline2.copyWith(color: Colors.transparent),
                headline2,
                progress,
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          Positioned(
            top: 20,
            left: 15,
            right: 15,
            child: Opacity(
              opacity: (1 - shrinkOffset / maxExtent),
              child: const SearchBar(),
            ),
          ),
          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: (1 - shrinkOffset / maxExtent),
              child: const ChipList(),
            ),
          ),
          Positioned(
            top: 125,
            left: 15,
            right: 15,
            child: Opacity(
              opacity: (1 - shrinkOffset / maxExtent),
              child: RichText(
                textAlign: TextAlign.start,
                text: const TextSpan(
                  text: 'About 11,130 results for ',
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.brown,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Nunito',
                      fontStyle: FontStyle.normal
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Covid New Variant', style: TextStyle(
                        fontSize: 14,
                        color: AppColors.brown,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Nunito',
                        fontStyle: FontStyle.normal
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}