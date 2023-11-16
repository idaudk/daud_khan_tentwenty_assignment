// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_db_app/cubits/search_cubit/search_cubit.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/resources/color_manager.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/resources/values_manager.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController textEditingController;
  final double? height;
  final Color? color;
  final bool showActions;
  final bool disableBackButton;
  final Function()? onBack;

  final bool enableShadow;
  SearchAppBar({
    required this.textEditingController,
    Key? key,
    this.disableBackButton = false,
    this.height = AppSize.searchAppBarheight,
    this.color,
    this.showActions = false,
    this.enableShadow = false,
    this.onBack,
  }) : super(key: key);

  final _debouncer = Debouncer(milliseconds: 900);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? ColorManager.white,
      ),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(
        top: ScreenUtil().statusBarHeight + 10,
        bottom: AppSize.s20.h,
        left: AppSize.s24,
        right: AppSize.s24,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(AppSize.s50.r),
        color: ColorManager.textformBg,
        child: TextFormField(
          controller: textEditingController,
          onChanged: (v) {
            _debouncer.run(() {
              context.read<SearchCubit>().searchStart(keyword: v);
            });
          },
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (v) {
            if (context.read<SearchCubit>().searchCompleted) {
              if (v.isNotEmpty) {
                Navigator.pushNamed(context, Routes.search, arguments: v);
              }
            }
          },
          style: context.textTheme.bodyMedium,
          decoration: InputDecoration(
              hintText: 'TV Show, movies and more',
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<SearchCubit>().clearSearchField();
                },
                icon: Icon(
                  CupertinoIcons.xmark,
                  size: AppSize.s26.r,
                ),
              ),
              prefixIcon: Icon(
                CupertinoIcons.search,
                size: AppSize.s22.r,
              )),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height!);
}
