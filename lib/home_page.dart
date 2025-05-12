import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/home_cubit.dart';
import 'package:newsapp/title_headline_widget.dart';
import 'package:newsapp/custom_carousel_slider.dart';
import 'package:newsapp/app_bar_button.dart';
import 'package:newsapp/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeCubit = HomeCubit();
        homeCubit.getTopHeadlines();

        return homeCubit;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBarButton(
              iconData: Icons.menu,
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          actions: [
            AppBarButton(
              iconData: Icons.search,
              hasPaddingBetween: true,
              onTap: () => (),
            ),
            const SizedBox(width: 8),
            AppBarButton(
              iconData: Icons.notifications_none_rounded,
              hasPaddingBetween: true,
              onTap: () {},
            ),
            const SizedBox(width: 12),
          ],
        ),
        drawer: const AppDrawer(),
        body: SafeArea(
          child: Builder(builder: (context) {
            final homeCubit = BlocProvider.of<HomeCubit>(context);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TitleHeadlineWidget(
                      title: 'Breaking News',
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 280,
                      child: BlocBuilder<HomeCubit, HomeState>(
                        bloc: homeCubit,
                        buildWhen: (previous, current) =>
                            current is TopHeadlinesLoading ||
                            current is TopHeadlinesLoaded ||
                            current is TopHeadlinesError,
                        builder: (context, state) {
                          if (state is TopHeadlinesLoading) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else if (state is TopHeadlinesLoaded) {
                            final articles = state.articles;
                            return CustomCarouselSlider(
                              articles: articles ?? [],
                            );
                          } else if (state is TopHeadlinesError) {
                            return Center(
                              child: Text(state.message),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    TitleHeadlineWidget(
                      title: 'Recommendation',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
