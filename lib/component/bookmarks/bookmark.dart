import 'dart:convert';

import 'package:ezar/model/news_article_model.dart';
import 'package:ezar/router/router_constant.dart';
import 'package:ezar/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  List<Articlesmodle> newsArticle = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNewsArticle();
  }

  Future<void> _loadNewsArticle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonArray = prefs.getStringList('newsArticle') ?? [];
    print("-------- ${jsonArray}");
    List<Articlesmodle> articles = [];
    for (String jsonString in jsonArray) {
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      Articlesmodle article = Articlesmodle.fromJson(jsonData);
      articles.add(article);
    }
    setState(() {
      newsArticle = articles;
    });
    print("-------- ${newsArticle}");
  }
Future<void> removeData(Articlesmodle jsonData,index) async {
 
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> jsonArray = prefs.getStringList('newsArticle') ?? [];
        List<String> indexList = prefs.getStringList('index') ?? [];
    String jsonString = jsonEncode(jsonData);

    indexList.remove(indexList[index].toString());
    print(".......... $indexList");
      jsonArray.remove(jsonString);
      await prefs.setStringList('newsArticle', jsonArray);
      await prefs.setStringList("index",indexList);
     _loadNewsArticle();
  }
  @override
  Widget build(BuildContext context) {
    String defaultUrl =
        "https://cdn.vox-cdn.com/thumbor/PvTs1AQvbet47Qzg0cODmNIxq7c=/0x0:2040x1360/1200x628/filters:focal(1020x680:1021x681)/cdn.vox-cdn.com/uploads/chorus_asset/file/23935560/acastro_STK103__03.jpg";

    return Scaffold(
      appBar: AppStyles.commonAppbar(context, "Bookmarks",
          showLeading: true, showBookMarks: false,leadingOnPressed: (){
            GoRouter.of(context).pushNamed(RouterConstant.home);
          }),
      body: Container(
        child: ListView.builder(
            itemCount: newsArticle.length,
            itemBuilder: (context, index) {
             int cutLen =0;
                                if(newsArticle[index].description != null){
                              cutLen=   newsArticle[index].description!
                                            .length >=
                                        50
                                    ? 50
                                    : newsArticle[index].description!.length;
                                }
              return GestureDetector(
                onTap: (){
                  GoRouter.of(context).pushNamed(RouterConstant.article,extra:newsArticle[index]);
                },
                child: ListTile(
                  leading:
                      Image.network(newsArticle[index].urlToImage ?? defaultUrl),
                  title: Text(
                    newsArticle[index].title.toString().substring(0, 30) + '....',
                    style: AppStyles.white16bold,
                    
                  ),
                  subtitle: Text("${newsArticle[index].description.toString().substring(0,cutLen)} ${cutLen<50 ? "" : "...."}",style: AppStyles.white14regular,),
                  trailing: GestureDetector(onTap: (){
                        removeData(newsArticle[index],index);
                  },
                  child: Icon(Icons.bookmark),),
                ).marginOnly(top: 20.h),
              );
            }),
      ),
    );
  }
}
