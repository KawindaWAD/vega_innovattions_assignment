import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vega_innovattions_assignmen/core/enums/bloc_state_status.dart';
import 'package:vega_innovattions_assignmen/core/utils/colors.dart';
import 'package:vega_innovattions_assignmen/features/all_news/presentation/widgets/header.dart';

import '../../../core/utils/text_style.dart';
import '../../../injector.dart';
import '../../common/presentation/widgets/article_card.dart';
import '../../common/presentation/widgets/error_widget.dart';
import '../../dashboard/presentation/bloc/top_news/top_news_bloc.dart';
import '../../dashboard/presentation/widgets/shimmers/article_card_shimmer.dart';
import 'bloc/all_news/all_news_bloc.dart';

class AllNewsScreenWrapper extends StatelessWidget {
  final AllNewsState newsState;
  const AllNewsScreenWrapper({Key? key, required this.newsState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllNewsBloc>(
          create: (context) => AllNewsBloc(getNews: sl(), allNewsState: newsState),
        ),
        BlocProvider<TopNewsBloc>(
          create: (context) => sl<TopNewsBloc>(),
        ),
      ],
      child: const AllNewsScreen(),
    );
  }
}

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Material(
          color: AppColors.white,
          child: CustomScrollView(
            controller: context.read<AllNewsBloc>().scrollController,
            slivers: [
              const SliverPersistentHeader(
                // delegate: MySliverAppBar(expandedHeight: 200, article: article),
                delegate: AllNewsHeaderDelegate(),
                pinned: true,
                floating: true,
              ),
              BlocBuilder<AllNewsBloc, AllNewsState>(
                builder: (context, state) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) {
                        if(state.status == Status.loadSuccess || state.status == Status.loadFailure) {
                          if(state.news.articles.isEmpty) {
                            return const SizedBox();
                          } else {
                            return ArticleCard(article: state.news.articles.elementAt(index),);
                          }
                        }
                        return const ArticleCardShimmer();
                      },
                      childCount: state.status == Status.loadSuccess? state.news.articles.length : 10,
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<AllNewsBloc, AllNewsState>(
                  // buildWhen: (previous, current) {
                  //   if(previous.nextPage != current.nextPage || previous.searchText != current.searchText) {
                  //     return true;
                  //   }
                  //   return false;
                  // },
                  builder: (context, state) {
                    if(state.status == Status.loadFailure) {
                      return ErrorDisplayWidget(message: state.errorMessage,);
                    }

                    return (state.pageNumber-1)*20 < state.news.totalResults?  Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child:  CupertinoActivityIndicator(
                          radius: 20.0.w, color: AppColors.red),
                    ) : const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
