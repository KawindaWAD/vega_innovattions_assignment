part of 'breaking_news_bloc.dart';

abstract class BreakingNewsEvent extends Equatable {
  const BreakingNewsEvent();
}

class BreakingNewsRequested extends BreakingNewsEvent {
  const BreakingNewsRequested();

  @override
  List<Object?> get props => [];
}
