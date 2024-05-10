import 'dart:convert';
import 'dart:ffi';

import 'package:ezar/component/Home/bloc/home_bloc.dart';
import 'package:ezar/model/news_article_model.dart';
import 'package:ezar/router/router_constant.dart';
import 'package:ezar/utils/app_colors.dart';
import 'package:ezar/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Category extends StatefulWidget {
  dynamic item;
  Category({super.key, required this.item});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> with TickerProviderStateMixin {
  ScrollController controller = ScrollController();
  HomeBloc homeBloc = HomeBloc();
  String searchVal = "";
  List<String> list = [];
  List<String> jsonArray = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    print("kkkkkkkk ${widget.item['name']}");
    homeBloc.add(HomeInitialEvent(widget.item['name']));
    controller.addListener(() {
      print("hrlllo");
      if (controller.position.maxScrollExtent == controller.offset) {
        homeBloc.add(HomeInitialEvent(widget.item['name']));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> indexList = await prefs.getStringList("index") ?? [];
    jsonArray = prefs.getStringList('newsArticle') ?? [];
    print("========== $indexList");
    setState(() {
      list = indexList;
    });
  }

  Future<void> _storeData(Articlesmodle jsonData, index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    jsonArray = prefs.getStringList('newsArticle') ?? [];
    List<String> indexList = prefs.getStringList("index") ?? [];
    String jsonString = jsonEncode(jsonData);
    if (jsonArray.contains(jsonString)) {
      jsonArray.remove(jsonString);
      indexList.remove(index.toString());
      await prefs.setStringList('newsArticle', jsonArray);
      await prefs.setStringList("index", indexList);
    } else {
      jsonArray.add(jsonString);
      indexList.add(index.toString());
      await prefs.setStringList('newsArticle', jsonArray);
      await prefs.setStringList("index", indexList);
    }

    setState(() {});
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
            appBar: AppStyles.commonAppbar(context, "Category",
                showLeading: true, leadingOnPressed: () {
              GoRouter.of(context).goNamed(RouterConstant.home);
            }),
            body: state.runtimeType != HomeSuccessState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchVal = value;
                              });
                            },
                            style: AppStyles.white14regular,
                            decoration: InputDecoration(
                                labelText: "Search",
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      print("serch tap ${searchVal}");
                                      if (searchVal.length > 0) {
                                        homeBloc.add(
                                            HomeSearchEvent(searchVal,));
                                      }
                                    },
                                    child: Icon(Icons.search))),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        RefreshIndicator(
                          onRefresh: () async {
                            homeBloc.add(HomeInitialEvent(widget.item['name']));
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * 1,
                              width: MediaQuery.of(context).size.width * 1,
                              child: ListView.builder(
                                  controller: controller,
                                  itemCount: state.articles!.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < state.articles!.length) {
                                      String url =
                                          state.articles?[index].urlToImage ??
                                              defaultUrl;
                                      int cutLen = 0;
                                        int titleLen = 0;
                                      if (state.articles?[index].description !=
                                          null) {
                                        cutLen = state.articles![index]
                                                    .description!.length >=
                                                50
                                            ? 50
                                            : state.articles![index]
                                                .description!.length;
                                      }
                                      if (state.articles?[index].title !=
                                          null) {
                                        titleLen = state.articles![index]
                                                    .title!.length >=
                                                30
                                            ? 30
                                            : state.articles![index]
                                                .title!.length;
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          GoRouter.of(context).pushNamed(
                                              RouterConstant.article,
                                              extra: state.articles![index]);
                                        },
                                        child: ListTile(
                                          leading: Image.network(
                                            url,
                                            width: 60.w,
                                            height: 60.h,
                                          ),
                                          title: Text(
                                            state.articles![index].title
                                                    .toString()
                                                    .substring(0, titleLen) +
                                                '....',
                                            style: AppStyles.white16bold,
                                          ),
                                          subtitle: Text(
                                            "${state.articles?[index].description.toString().substring(0, cutLen)} ${cutLen < 50 ? "" : "...."}",
                                            style: AppStyles.white14regular,
                                          ),
                                          trailing: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (list.contains(
                                                      index.toString())) {
                                                    list.remove(
                                                        index.toString());
                                                    _storeData(
                                                        state.articles![index],
                                                        index);
                                                  } else {
                                                    list.add(index.toString());
                                                    _storeData(
                                                        state.articles![index],
                                                        index);
                                                  }
                                                });
                                              },
                                              child: list.contains(
                                                          index.toString()) &&
                                                      jsonArray.contains(
                                                          jsonEncode(
                                                              state.articles![
                                                                  index]))
                                                  ? Icon(
                                                      Icons.bookmark,
                                                    )
                                                  : Icon(Icons
                                                      .bookmark_add_outlined)),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  })),
                        ),
                      ],
                    ),
                  )));
      },
    );
  }
}
