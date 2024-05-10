import 'package:ezar/model/news_article_model.dart';
import 'package:ezar/router/router_constant.dart';
import 'package:ezar/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Article extends StatefulWidget {
  Articlesmodle data;
  Article({super.key, required this.data});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
      String dateString = widget.data.publishedAt.toString();
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";

    String defaultUrl =
        "https://cdn.vox-cdn.com/thumbor/PvTs1AQvbet47Qzg0cODmNIxq7c=/0x0:2040x1360/1200x628/filters:focal(1020x680:1021x681)/cdn.vox-cdn.com/uploads/chorus_asset/file/23935560/acastro_STK103__03.jpg";

    return Scaffold(
      appBar: AppStyles.commonAppbar(context, "Category", showLeading: true,
          leadingOnPressed: () {
        GoRouter.of(context).goNamed(RouterConstant.home);
      }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.data.urlToImage ?? defaultUrl),
            SizedBox(
              height: 10.h,
            ),
            Text(
              widget.data.title.toString(),
              style: AppStyles.white16bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              widget.data.content == null ? "no data found" :widget.data.content.toString(),
              style: AppStyles.white14regular,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        child: Text(formattedDate,style: AppStyles.white14regular,),
      ),
    );
  }
}
