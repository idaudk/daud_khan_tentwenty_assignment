import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.pageBg,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(CupertinoIcons.left_chevron),
              onPressed: () {
                Navigator.pop(context);
              }),
          toolbarHeight: AppSize.s100.h,
          elevation: 0,
          backgroundColor: ColorManager.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'The King\'s man',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium,
              ),
              Gap(AppSize.s5.h),
              Text(
                'In Theaters December 22, 2021',
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall!
                    .copyWith(color: ColorManager.aqua),
              ),
            ],
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s24,
            ),
            child: Text('Date', style: context.textTheme.headlineMedium),
          ),
          Gap(AppSize.s10.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s24,
            ),
            child: Row(
              children: [
                for (var i = 0; i < 7; i++)
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.s20.w, vertical: AppSize.s10.h),
                    margin: EdgeInsets.only(right: AppSize.s10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: ColorManager.lightGrey.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Text(
                        '${(i + 1).toString()} Mar',
                        style: context.textTheme.labelMedium!
                            .copyWith(fontWeight: FontWeightManager.semiBold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Gap(AppSize.s20.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var i = 0; i < 4; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '12.30',
                                style: context.textTheme.bodySmall!
                                    .copyWith(color: ColorManager.text),
                              ),
                              Gap(AppSize.s10.w),
                              Text(
                                'CineTech + Hall 1',
                                style: context.textTheme.bodySmall,
                              )
                            ],
                          ),
                          Gap(AppSize.s5.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.s20.w,
                                vertical: AppSize.s20.h),
                            width: ScreenUtil().screenWidth * 0.6,
                            margin: EdgeInsets.only(right: AppSize.s10.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: ColorManager.aqua),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                                child: CustomPaint(
                              painter: CurvePainter(),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.s20.w,
                                    vertical: AppSize.s5.h),
                                width: double.infinity,
                                height: 100,
                              ),
                            )),
                          ),
                          Gap(AppSize.s5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'From ',
                                style: context.textTheme.bodySmall!.copyWith(),
                              ),
                              Text(
                                '50\$',
                                style: context.textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeightManager.semiBold,
                                    color: ColorManager.text),
                              ),
                              Text(
                                ' or ',
                                style: context.textTheme.bodySmall!.copyWith(),
                              ),
                              Text(
                                '2500 bonus',
                                style: context.textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeightManager.semiBold,
                                    color: ColorManager.text),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorManager.aqua
          .withOpacity(0.5) // Set your desired background color
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.1); // Start at the top-left corner

    // Increase the symmetrical bend by adjusting control points
    path.quadraticBezierTo(
      size.width * 0.5, // Control point x
      -size.height * 0.2, // Control point y
      size.width, // End point x
      size.height * 0.1, // End point y
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
