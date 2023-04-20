import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/entities/news_entity.dart';
import 'package:vega_innovattions_assignmen/features/common/presentation/bounce_widget.dart';

import '../../../../core/utils/colors.dart';
import '../../../news_details/presentation/news_details_screen.dart';
import '../shimmer_loader.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
      child: Bounce(
        borderRadius: 8,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsScreen(article: article),));
        },
        child: Container(
          height: 128,
          width: MediaQuery.of(context).size.width,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
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
                    left: 15,
                    top: 12.h,
                    right: 8,
                    child: Text(
                      article.title,
                      style: const TextStyle(
                        color: AppColors.whiteText,
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Positioned(
                    bottom: 12.h,
                    left: 15,
                    right: 8,
                    child: Text(
                      article.author,
                      style: const TextStyle(
                        color: AppColors.whiteText,
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        height: 2.5,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Positioned(
                    bottom: 12.h,
                    right: 15,
                    child: Text(
                      DateFormat("EEEE, d MMM yyyy").format(article.publishedAt),
                      style: const TextStyle(
                        color: AppColors.whiteText,
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        height: 2.5,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
