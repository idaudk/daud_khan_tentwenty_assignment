import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/search_cubit/search_cubit.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';
import 'package:movie_db_app/data/remote/base_api_service.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';
import 'package:movie_db_app/ui/widgets/image/custom_image.dart';

import '../../resources/values_manager.dart';

Padding SearchListTIle(Results searchResult, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: AppSize.s20.h),
    child: Container(
      width: double.infinity,
      child: Row(
        children: [
          Material(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s15.r),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s15.r),
              child: CustomImage(
                  width: AppSize.s140.w,
                  height: AppSize.s120.h,
                  fit: BoxFit.cover,
                  imageUrl: BaseApiService.imageBaseUrl +
                      searchResult.backdropPath.toString()),
            ),
          ),
          Gap(AppSize.s20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  searchResult.title.toString(),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleMedium!
                      .copyWith(fontSize: FontSize.s14.sp),
                ),
                Gap(AppSize.s5.h),
                searchResult.genreIds?.length == 0
                    ? const SizedBox.shrink()
                    : Text(
                        context.read<SearchCubit>().getGenreNameById(
                            searchResult.genreIds![0],
                            context.read<SearchCubit>().genres),
                        style: context.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.lightGrey),
                      )
              ],
            ),
          ),
          Gap(AppSize.s20.w),
          const Icon(
            CupertinoIcons.ellipsis,
            color: ColorManager.aqua,
          )
        ],
      ),
    ),
  );
}
