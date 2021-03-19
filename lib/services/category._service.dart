import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:outlook/configs/globalConfigs.dart';
import 'package:outlook/models/expert_model.dart';

class CategoryService {
  // reviews/reviews-list
  Dio dio = new Dio();

  // dio.interceptors.add();
  Future categoriesList(val, BuildContext context) async {
    Response response;
    var body = val;
    // dio.interceptors
    //     .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
    response = await dio.post(
      '$baseUrl/categories/list-categories',
      data: body,
      // options: buildCacheOptions(Duration(days: 7), forceRefresh: true)
      // options:
      //     new Options(contentType: ContentType.parse("application/json"))
    );

    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while upload  data");
    }
    return response.data;
  }

  Future subcategoriesList(val, BuildContext context) async {
    Response response;
    var body = val;
    // dio.interceptors
    //     .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
    response = await dio.post(
      '$baseUrl/categories/list-categories',
      data: body,
      // options: buildCacheOptions(Duration(days: 7), forceRefresh: true)
      // options:
      //     new Options(contentType: ContentType.parse("application/json"))
    );

    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while upload  data");
    }
    return response.data;
  }

  Future subcategoriesListByCatID(val, BuildContext context) async {
    Response response;
    var body = val;
    // dio.interceptors
    //     .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
    response = await dio.post(
      '$baseUrl/categories/list-subcategories-catId',
      data: body,
      // options: buildCacheOptions(Duration(days: 7), forceRefresh: true)
      // options:
      //     new Options(contentType: ContentType.parse("application/json"))
    );

    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while upload  data");
    }
    return response.data;
  }

  Future updatecategoryExpert(ExpertModel expert, category, action) async {
    print(expert.id);
    Response response;
    var body = {
      "action": action,
      "category": category,
      "_key": expert.id,
    };

    response = await dio.post(
      '$baseUrl/categories/expert-update-category',
      data: body,
      // options:
      //     new Options(contentType: ContentType.parse("application/json"))
    );

    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while upload  data");
    }
    ExpertModel user = ExpertModel.fromDoc(response.data);

    return user;
  }
}
