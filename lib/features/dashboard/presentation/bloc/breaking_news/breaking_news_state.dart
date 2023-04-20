part of 'breaking_news_bloc.dart';

class BreakingNewsState extends Equatable {
  final Status status;
  final News news;
  final int pageNumber;
  final String errorMessage;

  const BreakingNewsState({
    this.status = Status.initial,
    required this.news,
    this.pageNumber = 0,
    this.errorMessage = '',
  });

  @override
  List<Object> get props =>
      [status, news, pageNumber, errorMessage,];

  BreakingNewsState copyWith({
    Status? status,
    News? news,
    int? pageNumber,
    String? errorMessage,
  }) {
    return BreakingNewsState(
      status: status ?? this.status,
      news: news ?? this.news,
      pageNumber: pageNumber ?? this.pageNumber,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}