import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/entities/news_entity.dart';

import '../../../../core/utils/colors.dart';
import '../../../common/presentation/shimmer_loader.dart';

class SliderCard extends StatelessWidget {
  final Article article;
  const SliderCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
            clipBehavior: Clip.antiAlias,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                CachedNetworkImage(
                  imageUrl: article.urlToImage,
                  placeholder: (context, url) => shimmerLoader(),
                  errorWidget: (context, url, error) => Image.asset('assets/images/error_background.jpg', fit: BoxFit.cover,),
                  fit: BoxFit.cover,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                ),
                Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  //bottom: 30.h,
                  left: 15,
                  right: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "By ${article.author}",
                        style: const TextStyle(
                          color: AppColors.whiteText,
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          height: 2.5,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        article.title,
                        style: const TextStyle(
                          color: AppColors.whiteText,
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  left: 15,
                  right: 8,
                  child: Text(
                    article.description,
                    style: const TextStyle(
                      color: AppColors.whiteText,
                      fontFamily: 'Nunito',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}