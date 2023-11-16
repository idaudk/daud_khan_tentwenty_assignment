// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/search_cubit/search_cubit.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';

class SearchScreenSimpleAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final double? height;
  final String title;
  final Color? color;
  final Function()? onBack;

  final bool enableShadow;
  SearchScreenSimpleAppbar({
    Key? key,
    this.height = AppSize.simpleAppBarheight,
    required this.title,
    this.color,
    this.enableShadow = false,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().screenWidth,
        decoration: const BoxDecoration(
          color: ColorManager.white,
        ),
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(
          top: ScreenUtil().statusBarHeight + 10,
          bottom: AppSize.s15.h,
          left: AppSize.s15,
          right: AppSize.s15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.left_chevron)),
            Gap(AppSize.s15.w),
            Text(
              title,
              style: context.textTheme.headlineMedium,
            )
          ],
        ));
  }

  @override
  Size get preferredSize => Size(double.infinity, height!);
}
