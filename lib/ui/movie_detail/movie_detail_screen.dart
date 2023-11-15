import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_db_app/cubits/movie_deatil_cubit/movie_details_cubit.dart';
import 'package:movie_db_app/data/remote/base_api_service.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/movie_detail/components/back_appbar.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';
import 'package:movie_db_app/ui/widgets/image/custom_image.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({super.key});

  List<Color> predefinedColors = [
    ColorManager.aqua,
    ColorManager.pink,
    ColorManager.purple,
    ColorManager.primary,

    // Add more colors as needed
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: ColorManager.almostWhite,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsFailed) {
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().statusBarHeight + 20.h,
                  left: AppSize.s24,
                  right: AppSize.s24),
              child: Column(
                children: [
                  BackAppBar(contentColor: ColorManager.black),
                  const Expanded(
                      child: Center(
                    child: Icon(
                      CupertinoIcons.xmark_octagon,
                      color: ColorManager.error,
                    ),
                  ))
                ],
              ),
            );
          } else if (state is MovieDetailsLoading) {
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().statusBarHeight + 20.h,
                  left: AppSize.s24,
                  right: AppSize.s24),
              child: Column(
                children: [
                  BackAppBar(contentColor: ColorManager.black),
                  const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                ],
              ),
            );
          } else if (state is MovieDetailsLoaded) {
            final movieDetail = state.movieDetail;
            final movieImages = state.movieImages;
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      CustomImage(
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          imageUrl: BaseApiService.imageBaseUrl +
                              movieImages.posters![0].filePath.toString()),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().statusBarHeight + 20.h,
                            left: 24,
                            right: 24),
                        child: Column(
                          children: [
                            BackAppBar(),
                            const Expanded(child: SizedBox()),
                            CustomImage(
                                loaderHeight: 0,
                                loaderWidth: 0,
                                height: AppSize.s35.h,
                                imageUrl: BaseApiService.imageBaseUrl +
                                    movieImages.logos![0].filePath.toString()),
                            SizedBox(
                              height: AppSize.s15.h,
                            ),
                            Text(
                              'In Theaters ${DateFormat('MMMM dd, yyyy').format(DateTime.parse(movieDetail.releaseDate.toString()))}',
                              style: context.textTheme.titleMedium!.copyWith(
                                color: ColorManager.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Gap(AppSize.s10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSize.s40.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Get Tickets')),
                                  ),
                                ],
                              ),
                            ),
                            Gap(AppSize.s10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSize.s40.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.trailer,
                                            arguments: state.movieDetail.id);
                                      },
                                      icon:
                                          const Icon(Icons.play_arrow_rounded),
                                      label: const Text('Watch tralier'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .transparent, // Background color
                                        elevation: 0, // No shadow
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1), // Border color and width
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(AppSize.s30.h),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: ColorManager.white,
                    child: ListView(
                      padding: EdgeInsets.only(
                          left: AppSize.s30.w,
                          right: AppSize.s30.w,
                          top: AppSize.s30.h),
                      children: [
                        Text(
                          'Genres',
                          style: context.textTheme.headlineMedium!
                              .copyWith(fontSize: FontSize.s18.sp),
                        ),
                        SizedBox(
                          height: AppSize.s15.h,
                        ),
                        SizedBox(
                          height: AppSize.s35.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: movieDetail.genres?.length ?? 0,
                            itemBuilder: (context, index) {
                              final genre = movieDetail.genres![index];
                              // Get a random index for the color list
                              int randomIndex =
                                  Random().nextInt(predefinedColors.length);
                              Color randomColor = predefinedColors[randomIndex];
                              return Container(
                                margin: EdgeInsets.only(right: AppSize.s5.w),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.s10.w,
                                    vertical: AppSize.s2.h),
                                decoration: BoxDecoration(
                                    color: randomColor,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s20.r)),
                                child: Text(
                                  genre.name.toString(),
                                  style: context.textTheme.titleSmall!.copyWith(
                                    color: ColorManager.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: AppSize.s50.h,
                          thickness: 0.5,
                          color: ColorManager.black.withOpacity(0.1),
                        ),
                        Text(
                          'Overview',
                          style: context.textTheme.headlineMedium!
                              .copyWith(fontSize: FontSize.s18.sp),
                        ),
                        SizedBox(
                          height: AppSize.s15.h,
                        ),
                        Text(
                          movieDetail.overview.toString(),
                          style: context.textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: AppSize.s15.h,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
