import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/home_cubit/home_cubit.dart';
import 'package:movie_db_app/data/remote/base_api_service.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/home/components/movie_banner.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/appbar/simple_app_bar.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';
import 'package:movie_db_app/ui/widgets/image/custom_image.dart';
import 'package:movie_db_app/ui/widgets/nav/nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: ColorManager.transparent, // status bar color
    //   statusBarBrightness: Brightness.light,
    //   statusBarIconBrightness: Brightness.light,
    // ));
    return Scaffold(
      backgroundColor: ColorManager.almostWhite,
      appBar: const SimpleAppBar(),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<HomeCubit>().refreshHandler();
        },
        child: Stack(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeFailed) {
                  return const Center(
                    child: Icon(
                      CupertinoIcons.xmark_octagon,
                      color: ColorManager.error,
                    ),
                  );
                } else if (state is HomeLoaded) {
                  return Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(AppSize.s24),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.upcomingMovies.length,
                        controller: context.read<HomeCubit>().scrollController,
                        itemBuilder: (context, index) {
                          final movie = state.upcomingMovies[index];
                          return MovieBanner(
                            movieId: movie.id!,
                            title: movie.title.toString(),
                            imageLink: BaseApiService.imageBaseUrl +
                                movie.posterPath.toString(),
                          );
                        },
                      ));
                }
                return const SizedBox.shrink();
              },
            ),
            const BottomNav()
          ],
        ),
      ),
    );
  }
}
