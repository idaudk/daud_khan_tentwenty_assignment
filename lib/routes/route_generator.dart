import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/movie_deatil_cubits/movie_details_cubit.dart';
import 'package:movie_db_app/ui/home/home_screen.dart';
import 'package:movie_db_app/ui/movie_detail/movie_detail_screen.dart';

class Routes {
  static const String home = "/";
  static const String movieDetail = "/movie-detail";
}

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.movieDetail:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<MovieDetailsCubit>.value(
            value: MovieDetailsCubit(),
            child: const MovieDetailScreen(),
          ),
        );

      default:
        return _errorRoute();
    }
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
