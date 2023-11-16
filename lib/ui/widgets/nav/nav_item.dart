import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';

import '../../resources/color_manager.dart';
import '../../resources/resources.dart';

class NavItem extends StatelessWidget {
  String text;
  IconData icon;
  String svgPath;
  bool isActive;
  NavItem({
    required this.text,
    required this.icon,
    required this.svgPath,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(SvgAssets.dashboard),
        // Icon(
        //   icon,
        //   color: isActive ? ColorManager.white : ColorManager.grey,
        //   size: AppSize.s25.r,
        // ),
        Gap(AppSize.s5.h),
        Text(
          text,
          style: context.textTheme.labelMedium!.copyWith(
              fontWeight: isActive ? FontWeightManager.bold : null,
              color: isActive ? ColorManager.white : ColorManager.grey),
        )
      ],
    );
  }
}
