import 'package:dio/dio.dart';
import 'package:newsapp/app_constants.dart';
import 'package:newsapp/news_api_response.dart';
import 'package:newsapp/top_headlines_body.dart';

class HomeServices {
  final aDio = Dio();

  Future<NewsApiResponse> getTopHeadlines(TopHeadlinesBody body) async {
    try {
      aDio.options.baseUrl = AppConstants.baseUrl;
      final headers = {
        'Authorization': 'Bearer ${AppConstants.apiKey}',
      };
      final response = await aDio.get(
        AppConstants.topHeadlines,
        queryParameters: body.toMap(),
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(response.data); // Move print before return
        return NewsApiResponse.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Add this method to get all news for recommendations
  Future<NewsApiResponse> getAllNews({int page = 1, int pageSize = 20}) async {
    try {
      aDio.options.baseUrl = AppConstants.baseUrl;
      final headers = {
        'Authorization': 'Bearer ${AppConstants.apiKey}',
      };

      // You can use different parameters for all news
      // For example, get general news or remove category filter
      final response = await aDio.get(
        AppConstants.topHeadlines,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          // Remove category to get all types of news
          // Or use a different category for recommendations
          'category': 'general', // or remove this line entirely
          'country': 'us', // Add country parameter
        },
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print('All News Response: ${response.data}');
        return NewsApiResponse.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}