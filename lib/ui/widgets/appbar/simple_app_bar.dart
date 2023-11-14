// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_db_app/ui/resources/color_manager.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/resources/values_manager.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final String? title;
  final Color? color;
  final bool showActions;
  final bool showAddressActions;
  final bool disableBackButton;
  final bool showFavrt;
  final int? itemId;
  final Function()? onBack;
  final Function()? onFvrt;

  final bool enableShadow;
  const SimpleAppBar({
    Key? key,
    this.disableBackButton = false,
    this.height = AppSize.simpleAppBarheight,
    this.title,
    this.showAddressActions = false,
    this.color,
    this.showActions = false,
    this.enableShadow = false,
    this.showFavrt = false,
    this.itemId,
    this.onFvrt,
    this.onBack,
  }) : super(key: key);

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Watch',
            style: context.textTheme.headlineMedium,
          ),
          Icon(CupertinoIcons.search),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height!);
}
