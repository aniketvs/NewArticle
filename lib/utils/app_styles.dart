import 'package:ezar/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static AppBar commonAppbar(BuildContext context, String title,
      {Function()? notificationOnPressed,
      Function()? darkThemeOnPressed,
      bool automaticallyImplyLeading = true,
      double? titleSpacing,
      bool showLeading = false,
      dynamic? leadingWidthStyle,
      Color? icon1Color,
      IconData? icon1,
      IconData? icon2,
      void Function()? leadingOnPressed,
      Widget? leading}) {
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
       Padding(
         padding:  EdgeInsets.only(right:8.w),
         child: Icon(
          Icons.bookmark,
          size: 24.sp,
          color: AppColors.secondaryColorLight,
         ),
       )
      ],
    );
    
  }
   static TextStyle white16bold = TextStyle(
      letterSpacing: .024,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white);
}