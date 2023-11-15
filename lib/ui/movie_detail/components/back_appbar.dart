import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class BackAppBar extends StatelessWidget {
  Color contentColor;
  BackAppBar({
    this.contentColor = ColorManager.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.left_chevron,
            color: contentColor,
          ),
          SizedBox(
            width: AppSize.s20.w,
          ),
          Text(
            'Watch',
            style:
                context.textTheme.headlineMedium!.copyWith(color: contentColor),
          )
        ],
      ),
    );
  }
}