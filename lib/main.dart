import 'package:ezar/router/router_config.dart';
import 'package:ezar/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ezar',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.darkBlue,
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppColors.secondaryColorDark),
        useMaterial3: true,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color.fromRGBO(18, 18, 54, .2),
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: IconThemeData(
            color: AppColors.secondaryColorDark,
            size: 22.sp,
          ),
          selectedIconTheme: const IconThemeData(),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      routeInformationProvider:
          AppRouterConfig.appRouter.routeInformationProvider,
      routeInformationParser: AppRouterConfig.appRouter.routeInformationParser,
      routerDelegate: AppRouterConfig.appRouter.routerDelegate,
    );
  }
}
