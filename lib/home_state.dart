part of 'home_cubit.dart';


sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

// Top Headlines States
final class TopHeadlinesLoading extends HomeState {}

final class TopHeadlinesLoaded extends HomeState {
  final List<Article>? articles;

  const TopHeadlinesLoaded(this.articles);
}

final class TopHeadlinesError extends HomeState {
  final String message;

  const TopHeadlinesError(this.message);
}

// All News States (for recommendations)
final class AllNewsLoading extends HomeState {}

final class AllNewsLoaded extends HomeState {
  final List<Article>? articles;

  const AllNewsLoaded(this.articles);
}

final class AllNewsError extends HomeState {
  final String message;

  const AllNewsError(this.message);
}


