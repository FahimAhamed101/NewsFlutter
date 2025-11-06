import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/article_model.dart';
import 'package:newsapp/local_database_hive.dart';
import 'package:newsapp/top_headlines_body.dart';
import 'package:newsapp/home_services.dart';
import 'package:newsapp/app_constants.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServices();
  // final localDatabaseServices = LocalDatabaseServices();
  final localDatabaseHive = LocalDatabaseHive();

  Future<void> getTopHeadlines() async {
    emit(TopHeadlinesLoading());
    try {
      const body = TopHeadlinesBody(
        category: 'business',
        page: 1,
        pageSize: 7,
      );
      final result = await homeServices.getTopHeadlines(body);
      emit(TopHeadlinesLoaded(result.articles));
    } catch (e) {
      emit(TopHeadlinesError(e.toString()));
    }
  }

  // Add this method to get all news for recommendations
  Future<void> getAllNews() async {
    emit(AllNewsLoading());
    try {
      final result = await homeServices.getAllNews(
        page: 1,
        pageSize: 20, // You can adjust this number
      );
      emit(AllNewsLoaded(result.articles));
    } catch (e) {
      emit(AllNewsError(e.toString()));
    }
  }
}