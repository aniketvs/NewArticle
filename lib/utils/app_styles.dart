import 'package:ezar/router/router_constant.dart';
import 'package:ezar/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppStyles {
  static AppBar commonAppbar(BuildContext context, String title,
      {
      bool automaticallyImplyLeading = true,
      double? titleSpacing,
      bool showLeading = false,
      dynamic? leadingWidthStyle,
      bool showBookMarks=true,
      void Function()? leadingOnPressed,
      }) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: AppColors.primaryColorDark,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontSize: 20.sp),
      ),
      leading: showLeading
          ? IconButton(
              onPressed: leadingOnPressed ??
                  () {
                    Navigator.pop(context);
                  },
              icon: Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Icon(
                  Icons.home,
                  size: 24.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            )
          : null,
      titleSpacing: titleSpacing,
      leadingWidth: leadingWidthStyle ?? 50.w,
      actions: [
       showBookMarks ? Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: GestureDetector(
            onTap: (){
              GoRouter.of(context).pushNamed(RouterConstant.bookmark);
            },
            child: Icon(
              Icons.bookmark,
              size: 24.sp,
              color: AppColors.secondaryColorLight,
            ),
          ),
        ):SizedBox.shrink()
      ],
    );
  }

  static TextStyle white16bold = TextStyle(
      letterSpacing: .024,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white);
  static TextStyle white14regular = TextStyle(
    letterSpacing: .024,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.7),
  );
}
