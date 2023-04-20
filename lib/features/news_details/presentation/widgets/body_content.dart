import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/entities/news_entity.dart';

import '../../../../core/utils/colors.dart';

class BodyContent extends StatelessWidget {
  final Article article;
  const BodyContent({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          topLeft: Radius.circular(24.0),),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          35.verticalSpace,
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Description -  ',
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.brown,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito',
                  fontStyle: FontStyle.normal
              ),
              children: <TextSpan>[
                TextSpan(text: article.description, style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.brown,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                    fontStyle: FontStyle.normal
                )),
              ],
            ),
          ),
          25.verticalSpace,
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Content -  ',
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.brown,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito',
                  fontStyle: FontStyle.normal
              ),
              children: <TextSpan>[
                TextSpan(text: article.content, style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.brown,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                    fontStyle: FontStyle.normal
                )),
              ],
            ),
          ),
          25.verticalSpace,
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Source -  ',
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.brown,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito',
                  fontStyle: FontStyle.normal
              ),
              children: <TextSpan>[
                TextSpan(text: article.source.name, style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.brown,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                    fontStyle: FontStyle.normal
                )),
              ],
            ),
          ),
          25.verticalSpace,
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'Read more -  ',
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.brown,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito',
                  fontStyle: FontStyle.normal
              ),
              children: <TextSpan>[
                TextSpan(text: article.url, style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blueText,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                    fontStyle: FontStyle.normal
                )),
              ],
            ),
          ),
          25.verticalSpace,
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Sample -  ',
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.brown,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito',
                  fontStyle: FontStyle.normal
              ),
              children: <TextSpan>[
                TextSpan(text: "${article.description} ${article.description} ${article.description}", style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.brown,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                    fontStyle: FontStyle.normal
                )),
              ],
            ),
          ),
          25.verticalSpace,
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'More sample -  ',
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.brown,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito',
                  fontStyle: FontStyle.normal
              ),
              children: <TextSpan>[
                TextSpan(text: "${article.content} ${article.content} ${article.content} ${article.content}  ${article.content} ${article.content}", style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.brown,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                    fontStyle: FontStyle.normal
                )),
              ],
            ),
          ),
          35.verticalSpace,
        ],
      ),
    );
  }
}
