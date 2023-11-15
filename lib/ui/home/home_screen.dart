import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/home_cubit/home_cubit.dart';
import 'package:movie_db_app/data/remote/base_api_service.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/appbar/simple_app_bar.dart';
import 'package:movie_db_app/ui/widgets/image/custom_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.almostWhite,
      appBar: const SimpleAppBar(),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<HomeCubit>().refreshHandler();
        },
        child: BlocBuilder<HomeCubit, HomeState>(
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
      ),
      bottomNavigationBar: Container(
        color: ColorManager.darkPurple,
        height: 80,
      ),
    );
  }
}

class MovieBanner extends StatelessWidget {
  String title;
  String imageLink;
  MovieBanner({
    required this.imageLink,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.s20),
      height: AppSize.s210.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r), color: ColorManager.grey),
      child: InkWell(
        splashColor: ColorManager.transparent,
        onTap: () {
          Navigator.pushNamed(context, Routes.movieDetail);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CustomImage(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  imageUrl: imageLink),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(0, 0, 0, 0),
                      Color.fromARGB(200, 0, 0, 0),
                    ],
                    begin: FractionalOffset(0.0, 0.5),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: AppSize.s20.h,
                    right: AppSize.s20.w,
                    left: AppSize.s20.w),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyLarge!
                      .copyWith(color: ColorManager.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
