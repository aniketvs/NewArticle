import 'package:ezar/router/router_constant.dart';
import 'package:ezar/utils/app_assets.dart';
import 'package:ezar/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> list = [
      {"name": "Top Headlines", "path": AppAssets.headline},
      {"name": "Technology", "path": AppAssets.technology},
      {"name": "Business", "path": AppAssets.business},
      {"name": "Sports", "path": AppAssets.sports}
    ];
  handleClick(item){
GoRouter.of(context).pushNamed(RouterConstant.category,extra: 
  item
);
  }
    return Scaffold(
      appBar: AppStyles.commonAppbar(
        context,
        "Eaz₹ News",
        showLeading: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(list.length, (index) {
                  return ListTile(
                    leading: SvgPicture.asset(
                      list[index]['path'],
                      height: 40.h,
                      width: 40.w,
                      color: Colors.white,
                    ),
                    title: Text(
                      list[index]['name'],
                      style: AppStyles.white16bold,
                    ),
                    onTap: (){
                      handleClick(list[index]);
                    },
                  ).marginOnly(bottom: 10.h, left: 8.w);
                })),
          ],
        ),
      )),
    );
  }
}
