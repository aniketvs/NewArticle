import 'package:ezar/component/Home/bloc/home_bloc.dart';
import 'package:ezar/router/router_constant.dart';
import 'package:ezar/utils/app_colors.dart';
import 'package:ezar/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:go_router/go_router.dart';

class Category extends StatefulWidget {
  dynamic item;
  Category({super.key, required this.item});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> with TickerProviderStateMixin {
  PageController pageController = PageController();
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("kkkkkkkk ${widget.item['name']}");
    homeBloc.add(HomeInitialEvent(widget.item['name'], "10"));
  }

  @override
  Widget build(BuildContext context) {
    String defaultUrl =
        "https://cdn.vox-cdn.com/thumbor/PvTs1AQvbet47Qzg0cODmNIxq7c=/0x0:2040x1360/1200x628/filters:focal(1020x680:1021x681)/cdn.vox-cdn.com/uploads/chorus_asset/file/23935560/acastro_STK103__03.jpg";
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeErrorState) {
          Fluttertoast.showToast(msg: "something went wrong!");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppStyles.commonAppbar(context, "Category", showLeading: true,
              leadingOnPressed: () {
            GoRouter.of(context).goNamed(RouterConstant.home);
          }),
          body: state.runtimeType == HomeSuccessState
              ? SafeArea(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 1,
                        width: MediaQuery.of(context).size.width * 1,
                        child: PageView.builder(
                            controller: pageController,
                            scrollDirection: Axis.vertical,
                  
                            onPageChanged: (value) {
                              if (value > (int.parse(homeBloc.page) * 10)) {
                                homeBloc.add(HomeAddPageSizeEvent());
                                homeBloc.add(HomeInitialEvent(
                                    widget.item['name'], homeBloc.page));
                              }
                            },
                            itemCount: state.articles?.length,
                            itemBuilder: (context, index) {
                              String url = state.articles?[index].urlToImage ??
                                  defaultUrl;
                              return Text("hello",style: AppStyles.white16bold,);
                            }),
                      ).marginOnly(top: 20.h),
                      state.runtimeType == HomeLoadingMoreDataState
                          ? Center(
                              child: CircularProgressIndicator(
                              backgroundColor: AppColors.secondaryColorLight,
                            ))
                          : SizedBox.shrink()
                    ],
                  ))
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
