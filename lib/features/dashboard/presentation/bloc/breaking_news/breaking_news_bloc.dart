import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/entities/news_param.dart';

import '../../../../../core/enums/bloc_state_status.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../common/domain/entities/news_entity.dart';
import '../../../../common/domain/usecases/get_news.dart';
import '../../../../common/presentation/blocs/event_transformer.dart';

part 'breaking_news_event.dart';
part 'breaking_news_state.dart';

class BreakingNewsBloc extends Bloc<BreakingNewsEvent, BreakingNewsState> {
  GetNews getNews;

  BreakingNewsBloc({required this.getNews}) : super(const BreakingNewsState(news: News(totalResults: 0, articles: []))) {
    on<BreakingNewsRequested>(_dataRequested, transformer: Transformer.throttleDroppable());
  }

  Future<FutureOr<void>> _dataRequested(BreakingNewsRequested event, Emitter<BreakingNewsState> emit) async {
    /// Fetch data
    Either<Failure, News> result = await getNews(const NewsParams(page: 1, country: 'us'));
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
