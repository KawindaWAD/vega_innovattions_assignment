import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/bloc_state_status.dart';
import '../bloc/breaking_news/breaking_news_bloc.dart';
import 'shimmers/slider_card_shimmer.dart';
import 'slider_card.dart';

class NewsSlider extends StatelessWidget {
  const NewsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: BlocBuilder<BreakingNewsBloc, BreakingNewsState>(
        builder: (context, state) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 240.h,
              //aspectRatio: 325/240,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              scrollDirection: Axis.horizontal,
              padEnds: false,
            ),
            items: getSliderItems(state),
          );
        },
      ),
    );
  }

  List<Widget>? getSliderItems(BreakingNewsState state) {
    if(state.status == Status.loadSuccess) {
      return state.news.articles.sublist(0, 10).map((i) {
        return Builder(
          builder: (BuildContext context) {
            return SliderCard(article: i,);
          },
        );
      }).toList();
    } else {
      return [1,2,3].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return const SliderCardShimmer();
          },
        );
      }).toList();
    }
  }
}

