part of 'top_news_bloc.dart';

abstract class TopNewsEvent extends Equatable {
  const TopNewsEvent();
}

class TopNewsRequested extends TopNewsEvent {
  final String category;

  const TopNewsRequested({required this.category});

  @override
  List<Object?> get props => [category];
}
