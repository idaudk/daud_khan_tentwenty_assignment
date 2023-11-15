import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/search_cubit/search_cubit.dart';
import 'package:movie_db_app/data/remote/base_api_service.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/search/components/search_bar.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';
import 'package:movie_db_app/ui/widgets/image/custom_image.dart';
import 'package:movie_db_app/ui/widgets/nav/nav.dart';

class LiveSearchScreen extends StatefulWidget {
  const LiveSearchScreen({super.key});

  @override
  State<LiveSearchScreen> createState() => _LiveSearchScreenState();
}

class _LiveSearchScreenState extends State<LiveSearchScreen> {
  @override
  void initState() {
    context.read<SearchCubit>().getAllGenre();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorManager.pageBg,
      appBar: SearchAppBar(
          textEditingController:
              context.read<SearchCubit>().textEditingController),
      body: Stack(
        children: [
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchLoaded) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.s24, vertical: AppSize.s20.h),
                  children: [
                    Text(
                      'Top Results',
                      style: context.textTheme.labelMedium,
                    ),
                    Divider(
                      height: AppSize.s30.h,
                      color: ColorManager.black.withOpacity(0.2),
                      thickness: 0.5,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.only(bottom: AppSize.s100.h),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.search.results?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final searchResult = state.search.results![index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: AppSize.s20.h),
                          child: Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Material(
                                  color: ColorManager.white,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s15.r),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s15.r),
                                    child: CustomImage(
                                        width: AppSize.s110.w,
                                        height: AppSize.s110.h,
                                        fit: BoxFit.cover,
                                        imageUrl: BaseApiService.imageBaseUrl +
                                            searchResult.backdropPath
                                                .toString()),
                                  ),
                                ),
                                Gap(AppSize.s20.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        searchResult.title.toString(),
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.textTheme.titleMedium!
                                            .copyWith(
                                                fontSize: FontSize.s15.sp),
                                      ),
                                      Gap(AppSize.s5.h),
                                      searchResult.genreIds?.length == 0
                                          ? const SizedBox.shrink()
                                          : Text(
                                              context
                                                  .read<SearchCubit>()
                                                  .getGenreNameById(
                                                      searchResult.genreIds![0],
                                                      context
                                                          .read<SearchCubit>()
                                                          .genres),
                                              style: context
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeightManager
                                                              .medium,
                                                      color: ColorManager
                                                          .lightGrey),
                                            )
                                    ],
                                  ),
                                ),
                                Gap(AppSize.s20.w),
                                // const Expanded(child: SizedBox.shrink()),
                                const Icon(
                                  CupertinoIcons.ellipsis,
                                  color: ColorManager.aqua,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: context.read<SearchCubit>().genres.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      bottom: AppSize.s150.h,
                      top: AppSize.s20.h,
                      left: AppSize.s24,
                      right: AppSize.s24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.4,
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSize.s15.w,
                      mainAxisSpacing: AppSize.s15.w),
                  itemBuilder: (context, index) {
                    print(context.read<SearchCubit>().genres.length);
                    final genre = context.read<SearchCubit>().genres[index];
                    return Container(
                      padding: EdgeInsets.all(AppSize.s20.r),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s15.r),
                          color: ColorManager.lightGrey),
                      height: 100,
                      width: double.infinity,
                      child: Text(
                        genre.name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.headlineMedium!.copyWith(
                            fontSize: AppSize.s17.sp,
                            color: ColorManager.white),
                      ),
                    );
                  },
                );
              }
            },
          ),
          const BottomNav()
        ],
      ),
    );
  }
}
