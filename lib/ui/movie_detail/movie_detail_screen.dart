import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';
import 'package:movie_db_app/ui/widgets/image/custom_image.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.almostWhite,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                const CustomImage(
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg'),
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
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              CupertinoIcons.left_chevron,
                              color: ColorManager.white,
                            ),
                            SizedBox(
                              width: AppSize.s20.w,
                            ),
                            Text(
                              'Watch',
                              style: context.textTheme.headlineMedium!
                                  .copyWith(color: ColorManager.white),
                            )
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        'In Theater December 22, 2021',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: ColorManager.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(AppSize.s10.h),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppSize.s40.w),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: AppSize.s40.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.play_arrow_rounded),
                                label: const Text('Get Tickets'),
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.transparent, // Background color
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
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: AppSize.s5.w),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: AppSize.s10.w,
                              vertical: AppSize.s2.h),
                          decoration: BoxDecoration(
                              color: ColorManager.aqua,
                              borderRadius:
                                  BorderRadius.circular(AppSize.s20.r)),
                          child: Text(
                            'Action',
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
                    'paragraph here',
                    style: context.textTheme.bodySmall,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
