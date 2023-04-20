import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vega_innovattions_assignmen/core/enums/api_type.dart';
import 'package:vega_innovattions_assignmen/features/all_news/presentation/bloc/all_news/all_news_bloc.dart';
import 'package:vega_innovattions_assignmen/features/dashboard/presentation/bloc/breaking_news/breaking_news_bloc.dart';
import 'package:vega_innovattions_assignmen/features/dashboard/presentation/bloc/top_news/top_news_bloc.dart';
import 'package:vega_innovattions_assignmen/features/dashboard/presentation/widgets/top_articls_list.dart';

import '../../all_news/presentation/all_news_screen.dart';
import 'widgets/category_chip_list.dart';
import 'widgets/news_slider.dart';
import 'widgets/search_bar.dart';
import 'widgets/section_title.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            30.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(child: DashboardSearchBar()),
                  20.horizontalSpace,
                  SvgPicture.asset('assets/images/notification_icon.svg',
                    semanticsLabel: 'notification_icon',
                  )
                ],
              ),
            ),
            24.verticalSpace,
            SectionTitle(
              title: 'Breaking News',
              onPressed: () {
                final bloc = BlocProvider.of<BreakingNewsBloc>(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllNewsScreenWrapper(
                          newsState: AllNewsState(
                            status: bloc.state.status,
                            news: bloc.state.news,
                            pageNumber: bloc.state.pageNumber,
                            errorMessage: bloc.state.errorMessage,
                            selectedCategory: 'all',
                            selectedCountry: 'us',
                            apiType: ApiType.topHeaders,
                          )),
                    ));
              },
            ),
            const NewsSlider(),
            10.verticalSpace,
            const CategoryChipList(),
            8.verticalSpace,
            SectionTitle(
              title: 'Top News',
              onPressed: () {
                final bloc = BlocProvider.of<TopNewsBloc>(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllNewsScreenWrapper(
                          newsState: AllNewsState(
                              status: bloc.state.status,
                              news: bloc.state.news,
                              pageNumber: bloc.state.pageNumber,
                              errorMessage: bloc.state.errorMessage,
                              selectedCategory: bloc.state.selectedCategory,
                              selectedCountry: 'all',
                              apiType: ApiType.topHeaders
                          )),
                    ));
              },
            ),
            8.verticalSpace,
            const TopArticleList()
          ],
        ),
      ),
    );
  }
}

