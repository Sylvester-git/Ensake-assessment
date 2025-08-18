import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  late Dio dio;
  final String? baseUrl;
  final String? bearerToken;

  Api({this.baseUrl, this.bearerToken}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? "",
        receiveTimeout: Duration(seconds: 45),
        connectTimeout: Duration(seconds: 45),
        sendTimeout: Duration(seconds: 45),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "platform": Platform.isAndroid ? "android" : "ios",
          "language": "en",
          bearerToken == null ? "" : "Authorization": "Bearer $bearerToken",
        },
      ),
    );

    dio.interceptors.add(PrettyDioLogger(request: true));
  }
}
