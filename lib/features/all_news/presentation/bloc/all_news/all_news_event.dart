part of 'all_news_bloc.dart';

abstract class AllNewsEvent extends Equatable {
  const AllNewsEvent();
}

class NewsDataRequested extends AllNewsEvent {
  @override
  List<Object> get props => [];
}

class CategoryChanged extends AllNewsEvent {
  final String categoryName;

  const CategoryChanged({
    required this.categoryName,
  });

  @override
  List<Object> get props => [categoryName];
}

class FilterApplied extends AllNewsEvent {
  final String countryName;

  const FilterApplied({
    required this.countryName,
  });

  @override
  List<Object> get props => [countryName];
}