part of 'top_news_bloc.dart';

class TopNewsState extends Equatable {
  final Status status;
  final News news;
  final int pageNumber;
  final String errorMessage;
  final String selectedCategory;

  const TopNewsState({
    this.status = Status.initial,
    required this.news,
    this.pageNumber = 0,
    this.errorMessage = '',
    this.selectedCategory = 'general',
  });

  @override
  List<Object> get props => [status, news, pageNumber, errorMessage, selectedCategory];

  TopNewsState copyWith({
    Status? status,
    News? news,
    int? pageNumber,
    String? errorMessage,
    String? selectedCategory,
  }) {
    return TopNewsState(
      status: status ?? this.status,
      news: news ?? this.news,
      pageNumber: pageNumber ?? this.pageNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
