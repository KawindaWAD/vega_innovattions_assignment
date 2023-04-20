part of 'all_news_bloc.dart';

class AllNewsState extends Equatable {
  final Status status;
  final int pageNumber;
  final String errorMessage;
  final String selectedCategory;
  final String selectedCountry;
  final ApiType apiType;
  final News news;

  const AllNewsState({
    required this.status,
    required this.news,
    required this.pageNumber,
    required this.errorMessage,
    required this.selectedCategory,
    required this.selectedCountry,
    required this.apiType,
  });

  @override
  List<Object> get props =>
      [
        status,
        pageNumber,
        errorMessage,
        selectedCategory,
        selectedCountry,
        apiType,
        news,
      ];

  AllNewsState copyWith({
    Status? status,
    int? pageNumber,
    String? errorMessage,
    String? selectedCategory,
    String? selectedCountry,
    ApiType? apiType,
    News? news,
  }) {
    return AllNewsState(
      status: status ?? this.status,
      pageNumber: pageNumber ?? this.pageNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      apiType: apiType ?? this.apiType,
      news: news ?? this.news,
    );
  }
}