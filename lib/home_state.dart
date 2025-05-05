part of 'home_cubit.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

final class TopHeadlinesLoading extends HomeState {}

final class TopHeadlinesLoaded extends HomeState {
  final List<Article>? articles;

  const TopHeadlinesLoaded(this.articles);
}

final class TopHeadlinesError extends HomeState {
  final String message;

  const TopHeadlinesError(this.message);
}


