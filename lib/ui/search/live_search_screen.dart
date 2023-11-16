import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/search_cubit/search_cubit.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/search/components/search_bar.dart';
import 'package:movie_db_app/ui/search/components/search_list_tile.dart';
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
  void dispose() {
    RouteGenerator().dispose();
    super.dispose();
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
                        return SearchListTIle(searchResult, context);
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
                          color: ColorManager.purple.withOpacity(0.5)),
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
