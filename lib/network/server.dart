import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Server {
  late final Dio _dio;

  static final Map<String, Server> _cache = <String, Server>{};

  factory Server(String baseUrl) {
    return _cache.putIfAbsent(baseUrl, () => Server._internal(baseUrl));
  }

  factory Server.create(String baseUrl) {
    return Server(baseUrl);
  }

  Server._internal(String baseUrl) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      contentType: "application/json",
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    _dio = Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: handleRequest,
      onResponse: handleResponse,
      onError: handleError,
    ));
  }

  void handleRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("DISNEY_TOKEN");
    //
    // if (token != null) {
    //   options.headers.putIfAbsent("Authorization", () => token);
    // }

    // // 打印出请求路径和参数
    // if (kDebugMode) {
    // }

    handler.next(options);
  }

  void handleResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      if (response.data is Map) {
        Map resData = response.data as Map;
        int code = resData["code"];
        String msg = resData["msg"];

        if (code != 200) {
          // token invalid

          if (msg.contains("DioException")) {
            msg = msg.replaceAll("DioException", '');
          }
          msg = "接口提示:$msg";
          handler.reject(ServerException(requestOptions: response.requestOptions, response: response, message: msg));
        }
      } else {
        handler.next(response);
      }
    } else {
      handler.reject(ServerException(
        requestOptions: response.requestOptions,
        response: response,
        message: "接口异常",
      ));
    }

    if (kDebugMode) {
      print({
        "url": response.realUri,
        "args": response.requestOptions.method == "GET" ? response.requestOptions.queryParameters : response.requestOptions.data,
        "data": response.data
      });
    }
  }

  void handleError(DioException error, ErrorInterceptorHandler handler) {
    if (error.type == DioExceptionType.connectionError) {
      handler.reject(ServerException(
        requestOptions: error.requestOptions,
        response: error.response,
        type: error.type,
        message: "网络异常",
      ));
    } else if (error.type == DioExceptionType.connectionTimeout) {
      handler.reject(ServerException(
        requestOptions: error.requestOptions,
        response: error.response,
        type: error.type,
        message: "网络超时",
      ));
    } else if (error.type == DioExceptionType.sendTimeout) {
      handler.reject(ServerException(
        requestOptions: error.requestOptions,
        response: error.response,
        type: error.type,
        message: "请求超时",
      ));
    } else if (error.type == DioExceptionType.receiveTimeout) {
      handler.reject(ServerException(
        requestOptions: error.requestOptions,
        response: error.response,
        type: error.type,
        message: "响应超时",
      ));
    } else {
      handler.reject(ServerException(requestOptions: error.requestOptions, response: error.response, type: error.type, message: error.message ?? "未知异常"));
    }
  }

  Future getJson(String url, dynamic params) {
    return _dio.get(url, queryParameters: params);
  }

  Future postJson(String url, dynamic params) {
    return _dio.post(url, data: params);
  }

  Future putJson(String url, dynamic params) {
    return _dio.put(url, data: params);
  }

  Future deleteJson(String url, dynamic params) {
    return _dio.delete(url, data: params);
  }

  Future<Response<T>> getJson2<T>(String url, dynamic params) {
    return _dio.get<T>(url, data: params);
  }
}

class ServerException extends DioException {
  ServerException({
    required super.requestOptions,
    super.response,
    super.type = DioExceptionType.unknown,
    super.error,
    super.message,
  });

  factory ServerException.from(DioException cause) {
    return ServerException(
      requestOptions: cause.requestOptions,
      response: cause.response,
      type: cause.type,
      error: cause.error,
      message: cause.message,
    );
  }

  @override
  String toString() {
    String msg = '$message';
    if (error != null) {
      msg += '\nError: $error';
    }
    return msg;
  }
}
