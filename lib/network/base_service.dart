import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_actions_build/network/response_result.dart';
import 'package:flutter_web_actions_build/network/server.dart';

abstract class BaseService {
  final Server _server = Server.create("https://pep-service-internal.csprodb.shdrapps.disney.com");
  // final Server _server = Server.create("https://dev.usemock.com/664dafb9bddabec78dd4ceef");

  Future<Response> getJson(String url, dynamic params) async {
    Response response = await _server.getJson(url, params);
    return response;//convertResponseResult(response);
  }

  Future<ResponseResult> postJson(String url, dynamic params) async {
    Response response = await _server.postJson(url, params);
    return convertResponseResult(response);
  }

  Future<ResponseResult> putJson(String url, dynamic params) async {
    Response response = await _server.putJson(url, params);
    return convertResponseResult(response);
  }

  Future<ResponseResult> deleteJson(String url, dynamic params) async {
    Response response = await _server.deleteJson(url, params);
    return convertResponseResult(response);
  }

  ResponseResult convertResponseResult(Response response) {
    ResponseResult res = ResponseResult.fromJson(response.data);
    if (res.code != 200) {
      throw FlutterError(res.msg);
    }
    return res;
  }
}
