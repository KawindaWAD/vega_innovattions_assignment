import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vega_innovattions_assignmen/core/utils/colors.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/entities/news_entity.dart';

class FloatingArticleInfo extends StatelessWidget {
  final Article article;

  const FloatingArticleInfo({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Frame33Widget - FRAME - VERTICAL
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color.fromRGBO(245, 245, 245, 0.9),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateFormat("EEEE, d MMM yyyy").format(article.publishedAt),
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: AppColors.brown,
                fontFamily: 'Nunito',
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.w600,
                height: 1.7333332697550456,
                fontStyle: FontStyle.normal),
          ),
          const SizedBox(height: 8),
          Text(
            article.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: AppColors.brown,
                fontFamily: 'Nunito',
                fontSize: 16,
                letterSpacing: 0,
                fontWeight: FontWeight.w700,
                height: 1.2000000476837158,
                fontStyle: FontStyle.normal),
          ),
          const SizedBox(height: 8),
          Text(
            'Published by ${article.author}',
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: AppColors.brown,
                fontFamily: 'Nunito',
                fontSize: 11,
                letterSpacing: 0,
                fontWeight: FontWeight.w800,
                height: 1,
                fontStyle: FontStyle.normal),
          ),
        ],
      ),
    );
  }
}
