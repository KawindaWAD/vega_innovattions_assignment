import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/enums/api_type.dart';
import '../../../../../core/enums/bloc_state_status.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/const/const.dart';
import '../../../../common/domain/entities/news_entity.dart';
import '../../../../common/domain/entities/news_param.dart';
import '../../../../common/domain/usecases/get_news.dart';
import '../../../../common/presentation/blocs/event_transformer.dart';

part 'all_news_event.dart';
part 'all_news_state.dart';

class AllNewsBloc extends Bloc<AllNewsEvent, AllNewsState> {
  final AllNewsState allNewsState;
  final GetNews getNews;
  final ScrollController scrollController = ScrollController();

  AllNewsBloc({required this.allNewsState, required this.getNews}) : super(allNewsState) {
    on<NewsDataRequested>(_newsDataRequested, transformer: Transformer.throttleDroppable());
    on<CategoryChanged>(_categoryChanged, transformer: Transformer.throttleRestartable());
    on<FilterApplied>(_filterApplied, transformer: Transformer.throttleRestartable());

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) add(NewsDataRequested());
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= maxScroll;
  }

  Future<FutureOr<void>> _newsDataRequested(NewsDataRequested event, Emitter<AllNewsState> emit) async {
    /// Break if pagination is completed
    if((state.pageNumber-1) *20 >= state.news.totalResults) {
      return null;
    }

    String? cat = state.selectedCategory == 'all'? null : state.selectedCategory;
    String? country = state.selectedCountry == 'all'? null : state.selectedCategory;

    /// Fetch data
    Either<Failure, News> result = await getNews(NewsParams(page: state.pageNumber + 1, category: cat, country: country));
    result.fold((failure) {
      String message = '';
      if(failure is ServerFailure) {
        message = failure.message;
      } else if(failure is NoConnectionFailure) {
        message = "You are not connect to the internet!";
      } else {
        message = "Something went wrong!";
      }
      emit(state.copyWith(status: Status.loadFailure, errorMessage: message,));
    }, (newsData) {
      List<Article> originalList = state.news.articles.toList();
      originalList.addAll(newsData.articles);
      News allNews = News(totalResults: state.news.totalResults, articles: originalList);
      emit(state.copyWith(status: Status.loadSuccess, news: allNews, pageNumber: (state.pageNumber+1) ),);
    });
  }

  Future<FutureOr<void>> _categoryChanged(CategoryChanged event, Emitter<AllNewsState> emit) async {
    scrollController.jumpTo(0);
    emit(state.copyWith(status: Status.loadInProgress, selectedCategory: event.categoryName));

    String? cat = event.categoryName == 'all'? null : event.categoryName;
    String? country = state.selectedCountry == 'all'? null : state.selectedCountry;

    /// Either category of county should not null
    if(cat == null && country == null) {
      country = 'us';
    }

    /// Fetch data
    Either<Failure, News> result = await getNews(NewsParams(page: 1, category: cat, country: country));
    result.fold((failure) {
      String message = '';
      if(failure is ServerFailure) {
        message = failure.message;
      } else if(failure is NoConnectionFailure) {
        message = "You are not connect to the internet!";
      } else {
        message = "Something went wrong!";
      }
      emit(state.copyWith(status: Status.loadFailure, errorMessage: message, selectedCountry: country));
    }, (newsData) {
      emit(state.copyWith(status: Status.loadSuccess, news: newsData, pageNumber: 2, selectedCountry: country),);
    });
  }

  Future<FutureOr<void>> _filterApplied(FilterApplied event, Emitter<AllNewsState> emit) async {
    scrollController.jumpTo(0);
    emit(state.copyWith(status: Status.loadInProgress, selectedCountry: event.countryName));

    String? country = event.countryName == 'all'? null : event.countryName;
    String? cat = state.selectedCategory == 'all'? null : state.selectedCategory;

    /// Either category of county should not null
    if(cat == null && country == null) {
      cat = categoryStringList.first;
    }

    /// Fetch data
    Either<Failure, News> result = await getNews(NewsParams(page: 1, category: cat, country: country));
    result.fold((failure) {
      String message = '';
      if(failure is ServerFailure) {
        message = failure.message;
      } else if(failure is NoConnectionFailure) {
        message = "You are not connect to the internet!";
      } else {
        message = "Something went wrong!";
      }
      emit(state.copyWith(status: Status.loadFailure, errorMessage: message, selectedCategory: cat));
    }, (newsData) {
      emit(state.copyWith(status: Status.loadSuccess, news: newsData, pageNumber: 2, selectedCategory: cat),);
    });
  }
}
