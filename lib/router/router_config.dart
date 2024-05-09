import 'package:ezar/component/Home/home.dart';
import 'package:ezar/component/article/article.dart';
import 'package:ezar/component/category/category.dart';
import 'package:ezar/router/router_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouterConfig {
 static GoRouter appRouter = GoRouter(routes: [
    GoRoute(
      name: RouterConstant.home,
      path: '/',
      pageBuilder: (context, state) {
        return MaterialPage(child: Home());
      },
    ),
    GoRoute(
      name: RouterConstant.article,
      path: '/article',
      pageBuilder: (context, state) {
        return MaterialPage(child: Article());
      },
    ),
    GoRoute(
      name: RouterConstant.category,
      path: '/category',
      pageBuilder: (context, state) {
        return MaterialPage(child: Category());
      },
    )
  ]);
}
