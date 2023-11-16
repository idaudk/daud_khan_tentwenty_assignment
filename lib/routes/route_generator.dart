import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/movie_deatil_cubit/movie_details_cubit.dart';
import 'package:movie_db_app/cubits/search_cubit/search_cubit.dart';
import 'package:movie_db_app/cubits/search_results_cubit/search_results_cubit.dart';
import 'package:movie_db_app/cubits/trailer_cubit/trailer_cubit.dart';
import 'package:movie_db_app/data/models/search_model.dart';
import 'package:movie_db_app/ui/home/home_screen.dart';
import 'package:movie_db_app/ui/movie_detail/movie_detail_screen.dart';
import 'package:movie_db_app/ui/search/live_search_screen.dart';
import 'package:movie_db_app/ui/search_results/search_results_screen.dart';
import 'package:movie_db_app/ui/ticket/ticket_screen.dart';
import 'package:movie_db_app/ui/trailer/trailer_screen.dart';

class Routes {
  static const String home = "/";
  static const String movieDetail = "/movie-detail";
  static const String trailer = "/trailer";
  static const String liveSearch = "/live-search";
  static const String search = "/search";
  static const String tickets = "/tickets";
}

class RouteGenerator {
  SearchCubit searchCubit = SearchCubit();

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case Routes.movieDetail:
        final movieId = args as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<MovieDetailsCubit>.value(
            value: MovieDetailsCubit(movieId: movieId),
            child: MovieDetailScreen(),
          ),
        );

      case Routes.trailer:
        final movieId = args as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TrailerCubit>.value(
            value: TrailerCubit(movieId: movieId),
            child: const TrailerScreen(),
          ),
        );

      case Routes.liveSearch:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SearchCubit>.value(
            value: searchCubit,
            child: const LiveSearchScreen(),
          ),
        );

      case Routes.search:
        final keyword = args as String;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: SearchResultsCubit(),
              ),
              BlocProvider.value(
                value: searchCubit,
              ),
            ],
            child: SearchResultScreen(keyword: keyword),
          ),
        );

      case Routes.tickets:
        return MaterialPageRoute(
          builder: (context) => const TicketScreen(),
        );

      default:
        return _errorRoute();
    }
  }

  dispose() {
    searchCubit.close();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error while loading new page'),
        ),
      );
    });
  }
}
