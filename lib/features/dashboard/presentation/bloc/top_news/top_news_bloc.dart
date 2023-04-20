import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/enums/bloc_state_status.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../common/domain/entities/news_entity.dart';
import '../../../../common/domain/entities/news_param.dart';
import '../../../../common/domain/usecases/get_news.dart';
import '../../../../common/presentation/blocs/event_transformer.dart';

part 'top_news_event.dart';
part 'top_news_state.dart';

class TopNewsBloc extends Bloc<TopNewsEvent, TopNewsState> {
  GetNews getNews;

  TopNewsBloc({required this.getNews}) : super(const TopNewsState(news: News(totalResults: 0, articles: []))) {
    on<TopNewsRequested>(_dataRequested, transformer: Transformer.throttleRestartable());
  }

  Future<FutureOr<void>> _dataRequested(TopNewsRequested event, Emitter<TopNewsState> emit) async {
    emit(state.copyWith(status: Status.loadInProgress, selectedCategory: event.category));

    /// Fetch data
    Either<Failure, News> result = await getNews(NewsParams(page: 1, category: event.category));
    result.fold((failure) {
      String message = '';
      if(failure is ServerFailure) {
        message = failure.message;
      } if(failure is NoConnectionFailure) {
        message = "You are not connect to the internet!";
      } else {
        message = "Something went wrong!";
      }
      emit(state.copyWith(status: Status.loadFailure, errorMessage: message,));
    }, (newsData) {
      emit(state.copyWith(status: Status.loadSuccess, news: newsData, pageNumber: 2),);
    });
  }
}
