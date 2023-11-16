import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/ui/widgets/nav/nav_item.dart';

import '../../resources/resources.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            NavItem(
              svgPath: SvgAssets.dashboard,
              icon: Icons.dashboard_rounded,
              text: 'Home',
            ),
            NavItem(
              svgPath: SvgAssets.dashboard,
              isActive: true,
              icon: CupertinoIcons.play_rectangle_fill,
              text: 'Watch',
            ),
            NavItem(
              svgPath: SvgAssets.dashboard,
              icon: Icons.filter_rounded,
              text: 'Media Library',
            ),
            NavItem(
              svgPath: SvgAssets.dashboard,
              icon: CupertinoIcons.list_bullet,
              text: 'More',
            )
          ]),
        ));
  }
}
