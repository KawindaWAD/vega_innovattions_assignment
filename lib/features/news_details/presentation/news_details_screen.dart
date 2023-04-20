import 'package:flutter/material.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/entities/news_entity.dart';
import 'package:vega_innovattions_assignmen/features/news_details/presentation/widgets/body_content.dart';
import 'package:vega_innovattions_assignmen/features/news_details/presentation/widgets/header.dart';

import '../../../core/functions/change_status_bar.dart';
import '../../../core/utils/colors.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article article;
  const NewsDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    changeStatusBar(true);

    return WillPopScope(
      onWillPop: () async {
        changeStatusBar(false);
        return true;
      },
      child: Material(
        color: AppColors.white,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              // delegate: MySliverAppBar(expandedHeight: 200, article: article),
              delegate: CustomHeaderDelegate(article: article),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: BodyContent(article: article,),
            ),
          ],
        ),
      ),
    );
  }
}






