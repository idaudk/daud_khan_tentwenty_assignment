import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/ui/home/home_screen.dart';


class Routes {
  static const String home = "/";

}

class RouteGenerator {

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // case Routes.login:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<LoginBloc>.value(
      //       value: LoginBloc(loginRepo: _loginRepo),
      //       child: const LoginScreen(),
      //     ),
      //   );

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
