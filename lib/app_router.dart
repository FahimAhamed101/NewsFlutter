import 'package:newsapp/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/article_details_page.dart';
import 'package:newsapp/article_model.dart';
import 'home_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return CupertinoPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case AppRoutes.articleDetails:
        final article = settings.arguments as Article;
        return CupertinoPageRoute(
          builder: (_) => ArticleDetailsPage(
            article: article,
          ),
          settings: settings,
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
