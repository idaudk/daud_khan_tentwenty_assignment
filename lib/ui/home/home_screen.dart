import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/home_cubit/home_cubit.dart';
import 'package:movie_db_app/data/remote/base_api_service.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/appbar/simple_app_bar.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';
import 'package:movie_db_app/ui/widgets/image/custom_image.dart';

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
            Positioned(
                bottom: 0,
                child: Container(
                  width: ScreenUtil().screenWidth,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.s35.w, vertical: AppSize.s20.h),
                  decoration: BoxDecoration(
                      color: ColorManager.darkPurple,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(AppSize.s30.r),
                          topLeft: Radius.circular(AppSize.s30.r))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children: [
                        NavItem(
                          icon: Icons.dashboard_rounded,
                          text: 'Home',
                        ),
                        NavItem(
                          isActive: true,
                          icon: CupertinoIcons.play_rectangle_fill,
                          text: 'Watch',
                        ),
                        NavItem(
                          icon: Icons.filter_rounded,
                          text: 'Media Library',
                        ),
                        NavItem(
                          icon: CupertinoIcons.list_bullet,
                          text: 'More',
                        )
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  String text;
  IconData icon;
  bool isActive;
  NavItem({
    required this.text,
    required this.icon,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? ColorManager.white : ColorManager.grey,
          size: AppSize.s25.r,
        ),
        Gap(AppSize.s5.h),
        Text(
          text,
          style: context.textTheme.labelMedium!.copyWith(
              fontWeight: isActive ? FontWeightManager.bold : null,
              color: isActive ? ColorManager.white : ColorManager.grey),
        )
      ],
    );
  }
}

class MovieBanner extends StatelessWidget {
  String title;
  String imageLink;
  int movieId;
  MovieBanner({
    required this.imageLink,
    required this.title,
    required this.movieId,
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
          Navigator.pushNamed(context, Routes.movieDetail, arguments: movieId);
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
