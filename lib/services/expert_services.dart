import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:outlook/configs/globalConfigs.dart';
import 'package:outlook/models/expert_model.dart';

final expertServiceProvider = Provider<ExpertService>((ref) {
  return ExpertService(Dio());
});

class ExpertService {
  ExpertService(this._dio);

  final Dio _dio;
  Future<List<ExpertModel>> awaitExpertsList([int page = 1, _queryVal]) async {
    Response response;
    var body = {"skip": page, ..._queryVal};
    response = await _dio.post(
      '$baseUrl/expert-manage/category/waiting',
      data: body,
    );

    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while upload  data");
    }
    final results = List<Map<String, dynamic>>.from(response.data);
    print(results);
    List<ExpertModel> expertsList = results
        .map((data) => ExpertModel.fromDoc(data))
        .toList(growable: false);
    return expertsList;
  }

  Future expertsSearch(_queryVal) async {
    try {
      Response response;
      var body = {"skip": 0, ..._queryVal};

      response = await _dio.post(
        '$baseUrl/expert-manage/search',
        data: body,
        // options:
        //     new Options(contentType: ContentType.parse("application/json"))
      );

      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while upload  data");
      }

      final results = List<Map<String, dynamic>>.from(response.data);
      print(results);
      List<ExpertModel> expertsList = results
          .map((data) => ExpertModel.fromDoc(data))
          .toList(growable: false);
      return expertsList;
    } catch (exception, stackTrace) {
      print(exception);
      // await Sentry.Sentry.captureException(
      //   exception,
      //   stackTrace: stackTrace,
      // );
    }
  }
}
