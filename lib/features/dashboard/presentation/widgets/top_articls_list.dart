import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vega_innovattions_assignmen/core/enums/bloc_state_status.dart';

import '../../../common/presentation/widgets/article_card.dart';
import '../../../common/presentation/widgets/error_widget.dart';
import '../bloc/top_news/top_news_bloc.dart';
import 'shimmers/article_card_shimmer.dart';


class TopArticleList extends StatelessWidget {
  const TopArticleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopNewsBloc, TopNewsState>(
      builder: (context, state) {
        if(state.status == Status.loadFailure) {
          return ErrorDisplayWidget(message: state.errorMessage,);
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.status == Status.loadSuccess? (state.news.articles.length < 10? state.news.articles.length:10) : 5,
          itemBuilder: (context, index) {
            if(state.status == Status.loadSuccess) {
              return ArticleCard(article: state.news.articles.elementAt(index),);
            }
            return const ArticleCardShimmer();
          },
        );
      },
    );
  }
}
