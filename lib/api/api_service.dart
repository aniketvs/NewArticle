import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart' as DioApi;
import 'package:dio/dio.dart';
import 'package:ezar/api/endpoints.dart';
import 'package:ezar/model/news_article_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ApiService {
  static Dio _dio = Dio();
  static void init() async {
    try {
      var options = DioApi.BaseOptions(
          baseUrl: Endpoints.api,
          followRedirects: false,
          connectTimeout: const Duration(seconds: 500000),
          validateStatus: (status) {
            return status! < 400;
          });

      _dio = Dio(options);

      if (kDebugMode) {
        _dio.interceptors.add(
          LogInterceptor(
              responseBody: true,
              error: true,
              requestHeader: false,
              responseHeader: false,
              request: false,
              requestBody: true),
        );
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<dynamic> getRequest({
    endpoint,
    param,
    bool showNoInternet = false,
    bool isHeaderIncluded = false,
  }) async {
    try {
      if (kDebugMode) {
        print("--------------------");
        print("REQUEST TYPE : GET ");
        print("REQUEST END POINT : $endpoint");
        print("REQUEST DATA : $param");
      }
      if (isHeaderIncluded) {
        _dio.options.headers["Content-Type"] = "application/json";
      }

      var response = await _dio.get(
        endpoint,
        queryParameters: param,
      );
      if (response.statusCode == 200) {
          print("new REQUEST END POINT : $endpoint");
        return response;
      }

      // return response;
    } on DioException catch (err) {
      if (err.response!.statusCode == 505) {}
      rethrow;
    }
  }

  static Future<NewsArticleModel> getNews(param) async {
    final response = await getRequest(endpoint: Endpoints.api, param: param);
    print("kkkkkkkkkkk $response");
    if (response.statusCode != 200) {
    dynamic data = jsonDecode(response.data.toString());
      throw data['message'];
    }
    print("::::::::::: $response");
  
    return NewsArticleModel.fromJson(response.data);
  }
   static Future<NewsArticleModel> getSearchData(param) async {
    final response = await getRequest(endpoint: Endpoints.searchApi, param: param);
    print("kkkkkkkkkkk $response");
    if (response.statusCode != 200) {
    dynamic data = jsonDecode(response.data.toString());
      throw data['message'];
    }
    print("::::::::::: $response");
  
    return NewsArticleModel.fromJson(response.data);
  }
}
