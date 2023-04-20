import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/functions/change_status_bar.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../common/domain/entities/news_entity.dart';
import '../../../common/presentation/bounce_widget.dart';
import '../../../common/presentation/shimmer_loader.dart';
import 'floating_article_info.dart';

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Article article;

  const CustomHeaderDelegate({
    required this.article,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    return Stack(
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
        AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: 1 - progress,
          child: CachedNetworkImage(
            imageUrl: article.urlToImage,
            placeholder: (context, url) => shimmerLoader(),
            errorWidget: (context, url, error) => Image.asset('assets/images/error_background.jpg', fit: BoxFit.cover,),
            fit: BoxFit.cover,
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.lerp(
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            EdgeInsets.only(bottom: 16.h),
            progress,
          ),
          alignment: Alignment.lerp(
            Alignment.bottomLeft,
            Alignment.bottomCenter,
            progress,
          ),
          child: SizedBox(
            width: ScreenUtil().screenWidth/2,
            child: Text(
              article.title,
              style: TextStyle.lerp(
                headline2.copyWith(color: Colors.transparent),
                headline2,
                progress,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: (1 - shrinkOffset / maxExtent),
            child: Container(
              height: maxExtent * 0.2,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24.0),
                  topLeft: Radius.circular(24.0),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: (maxExtent / 2 - shrinkOffset) + (maxExtent * 0.1),
          left: 32,
          right: 32,
          child: Opacity(
            opacity: (1 - shrinkOffset / maxExtent),
            child: FloatingArticleInfo(article: article),
          ),
        ),
        Positioned(
          top: 40.h,
          left: 20,
          child: Bounce(
            borderRadius: 8,
            onTap: () {
              changeStatusBar(false);
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/images/back_button.svg',
              semanticsLabel: 'back_button',
              width: 32,
              height: 32,
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 350.h;

  @override
  double get minExtent => 84.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}