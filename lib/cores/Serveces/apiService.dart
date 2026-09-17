import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/cores/Serveces/databaseService.dart';
import 'package:ecommerce/cores/Serveces/endpoints.dart';

class Apiserver extends Databaseservce {
  final Dio dio;

  Apiserver({required this.dio});

  String _getUrl(String endpoint) {
    if (endpoint.startsWith('http')) {
      return endpoint;
    }

    return Endpoints.BaseUrl + endpoint;
  }

  @override
  Future<dynamic> getData({
    required String endpoints,
    String? token,
  }) async {
    Map<String, dynamic> header = {};

    if (token != null) {
      header.addAll({"token": token});
    }

    final url = _getUrl(endpoints);

    log("========== API REQUEST ==========");
    log("URL: $url");

    var response = await dio.get(
      url,
      options: Options(headers: header),
    );

    return response.data;
  }

  @override
  Future<dynamic> addData({
    required String endpoints,
    String? token,
    required Map<String, dynamic> body,
  }) async {
    Map<String, dynamic> header = {};

    if (token != null) {
      header.addAll({"token": token});
    }

    final url = _getUrl(endpoints);

    log("========== API REQUEST ==========");
    log("URL: $url");
    log("BODY: $body");
    log("HEADERS: $header");

    var response = await dio.post(
      url,
      data: body,
      options: Options(headers: header),
    );

    log("========== API RESPONSE ==========");
    log("STATUS CODE: ${response.statusCode}");
    log("RESPONSE DATA: ${response.data}");

    return response.data;
  }

  @override
  Future<dynamic> updateData({
    required String endpoints,
    String? token,
    required Map<String, dynamic> body,
  }) async {
    Map<String, dynamic> header = {};

    if (token != null) {
      header.addAll({"token": token});
    }

    final url = _getUrl(endpoints);

    log("========== API REQUEST ==========");
    log("URL: $url");

    var response = await dio.put(
      url,
      data: body,
      options: Options(headers: header),
    );

    log("========== API RESPONSE ==========");
    log("STATUS CODE: ${response.statusCode}");
    log("RESPONSE DATA: ${response.data}");

    return response.data;
  }

  @override
  Future<dynamic> deleteData({
    required String endpoints,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    Map<String, dynamic> header = {};

    if (token != null) {
      header.addAll({"token": token});
    }

    final url = _getUrl(endpoints);

    log("========== API REQUEST ==========");
    log("URL: $url");

    var response = await dio.delete(
      url,
      data: body,
      options: Options(headers: header),
    );

    log("========== API RESPONSE ==========");
    log("STATUS CODE: ${response.statusCode}");
    log("RESPONSE DATA: ${response.data}");

    return response.data;
  }
}