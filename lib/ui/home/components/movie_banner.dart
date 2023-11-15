import 'package:flutter/material.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/widgets/image/custom_image.dart';

import '../../resources/resources.dart';

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