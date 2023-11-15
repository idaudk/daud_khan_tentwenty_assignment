import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/home_cubit/home_cubit.dart';
import 'package:movie_db_app/ui/resources/resources.dart';

import 'routes/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        )
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp(
            title: Strings.appName,
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            initialRoute: Routes.home,
            onGenerateRoute: RouteGenerator().generateRoute,
          );
        },
      ),
    );
  }
}
